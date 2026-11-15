# Windows entry point. Mirrors install.sh: mise + tools + links + shell stub.
# Works in Windows PowerShell 5.1 and PowerShell 7. No admin, no Developer Mode.
[CmdletBinding()]
param(
  [switch]$Link  # only re-link configs (skip mise)
)

$ErrorActionPreference = 'Stop'
$DotfilesDir = $PSScriptRoot
$BackupDir = Join-Path $HOME ('.dotfiles-backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))

function Test-Command($Name) {
  [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

function Update-SessionPath {
  $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' +
    [Environment]::GetEnvironmentVariable('Path', 'User')
}

function Backup-Existing($Dst) {
  $item = Get-Item -LiteralPath $Dst -Force -ErrorAction SilentlyContinue
  if (-not $item) { return }
  if ($item.LinkType) {
    # A stale link: remove the link itself, never what it points at.
    $item.Delete()
    return
  }
  New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
  Write-Host "  -> backing up $Dst"
  Move-Item -LiteralPath $Dst -Destination $BackupDir
}

# Directories are linked with junctions. Unlike symlinks they need neither
# admin rights nor Developer Mode.
function Backup-AndLink($Src, $Dst) {
  $item = Get-Item -LiteralPath $Dst -Force -ErrorAction SilentlyContinue
  if ($item -and $item.LinkType -and ($item.Target -contains $Src)) {
    Write-Host "  ok $Dst (already linked)"
    return
  }
  Backup-Existing $Dst
  New-Item -ItemType Directory -Force -Path (Split-Path $Dst -Parent) | Out-Null
  New-Item -ItemType Junction -Path $Dst -Target $Src | Out-Null
  Write-Host "  ok $Dst -> $Src"
}

# Same idea as write_stub in install.sh: the profile is a stub that sources
# the repo, so the real config is never a link target.
function Write-Stub($Src, $Dst) {
  $stub = "# Managed by dotfiles. Real config lives in $Src`r`nif (Test-Path '$Src') { . '$Src' }"
  if ((Test-Path -LiteralPath $Dst) -and ((Get-Content -LiteralPath $Dst -Raw).Trim() -eq $stub)) {
    Write-Host "  ok $Dst (already stubbed)"
    return
  }
  Backup-Existing $Dst
  New-Item -ItemType Directory -Force -Path (Split-Path $Dst -Parent) | Out-Null
  Set-Content -LiteralPath $Dst -Value $stub -Encoding ASCII
  Write-Host "  ok $Dst -> sources $Src"
}

function Add-UserPath($Dir) {
  $user = [Environment]::GetEnvironmentVariable('Path', 'User')
  if (($user -split ';') -contains $Dir) { return }
  [Environment]::SetEnvironmentVariable('Path', ($user.TrimEnd(';') + ';' + $Dir), 'User')
  Write-Host "  ok added $Dir to user PATH"
}

function Install-Mise {
  if (Test-Command mise) {
    Write-Host "ok mise already installed: $(mise --version)"
    return
  }
  Write-Host 'Installing mise...'
  winget install --id jdx.mise -e --accept-source-agreements --accept-package-agreements --disable-interactivity
  Update-SessionPath
  if (-not (Test-Command mise)) { throw 'mise installation failed' }
  Write-Host "ok mise installed: $(mise --version)"
}

function Install-Tools {
  Write-Host 'Installing tools via mise...'
  # No stderr redirects on native commands: with ErrorActionPreference=Stop,
  # Windows PowerShell 5.1 turns redirected stderr into a terminating error.
  mise trust --quiet (Join-Path $DotfilesDir 'mise\config.toml')
  # skip sigstore attestation verify, corp proxies block TUF CDN
  $env:MISE_AQUA_GITHUB_ATTESTATIONS = 'false'
  mise install --cd (Join-Path $DotfilesDir 'mise')
  if ($LASTEXITCODE -ne 0) { throw 'mise install failed' }
  Write-Host 'ok tools installed'

  # No shell hook needed: shims on PATH work in every shell and for GUI apps.
  Add-UserPath (Join-Path $env:LOCALAPPDATA 'mise\shims')
  mise reshim
  Update-SessionPath

  if (Test-Command uv) {
    uv python install 3.12
    if ($LASTEXITCODE -eq 0) { Write-Host 'ok python 3.12 via uv' }
  }
}

# Nerd Font for nvim icons. The terminal draws them, so the font lives on the
# Windows side even when nvim runs inside WSL.
$FontFace = 'JetBrainsMono NF'
$FontPackage = 'DEVCOM.JetBrainsMonoNerdFont'

function Test-FontInstalled($Face) {
  foreach ($k in 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts',
                 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts') {
    $p = Get-ItemProperty $k -ErrorAction SilentlyContinue
    if ($p -and ($p.PSObject.Properties.Name -like "$Face*")) { return $true }
  }
  return $false
}

function Install-Font {
  if (Test-FontInstalled $FontFace) {
    Write-Host "ok font already installed: $FontFace"
    return
  }
  Write-Host "Installing $FontFace (asks for admin once)..."
  winget install --id $FontPackage -e --accept-source-agreements --accept-package-agreements --disable-interactivity
  if (Test-FontInstalled $FontFace) {
    Write-Host "ok font installed: $FontFace"
  } else {
    Write-Warning "font install failed, run: winget install $FontPackage"
  }
}

# Sets the default font for every Windows Terminal profile. Leaves a font the
# user already chose alone.
function Set-TerminalFont($Settings) {
  if (-not (Test-Path -LiteralPath $Settings)) {
    Write-Host '  -- Windows Terminal settings not found, skipping font'
    return
  }
  if (-not (Test-FontInstalled $FontFace)) {
    Write-Host "  -- $FontFace not installed, leaving terminal font alone"
    return
  }
  try {
    $json = Get-Content -LiteralPath $Settings -Raw | ConvertFrom-Json
  } catch {
    Write-Warning "could not parse $Settings, set the font to '$FontFace' by hand"
    return
  }
  if (-not $json.profiles) { return }
  if (-not $json.profiles.defaults) {
    $json.profiles | Add-Member -NotePropertyName defaults -NotePropertyValue ([pscustomobject]@{}) -Force
  }
  $defaults = $json.profiles.defaults
  if ($defaults.font -and $defaults.font.face) {
    Write-Host "  ok terminal font ($($defaults.font.face), left as is)"
    return
  }
  if (-not $defaults.font) {
    $defaults | Add-Member -NotePropertyName font -NotePropertyValue ([pscustomobject]@{}) -Force
  }
  $defaults.font | Add-Member -NotePropertyName face -NotePropertyValue $FontFace -Force

  New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
  Copy-Item -LiteralPath $Settings -Destination (Join-Path $BackupDir 'windows-terminal-settings.json')
  $text = $json | ConvertTo-Json -Depth 32
  [IO.File]::WriteAllText($Settings, $text, (New-Object Text.UTF8Encoding $false))
  Write-Host "  ok terminal font -> $FontFace"
}

function Link-Configs {
  Write-Host 'Linking configs...'
  # Neovim reads %LOCALAPPDATA%\nvim on Windows, mise reads ~\.config\mise.
  Backup-AndLink (Join-Path $DotfilesDir 'nvim') (Join-Path $env:LOCALAPPDATA 'nvim')
  Backup-AndLink (Join-Path $DotfilesDir 'mise') (Join-Path $HOME '.config\mise')

  # One profile for both Windows PowerShell 5.1 and PowerShell 7.
  $docs = [Environment]::GetFolderPath('MyDocuments')
  $profileSrc = Join-Path $DotfilesDir 'powershell\profile.ps1'
  Write-Stub $profileSrc (Join-Path $docs 'WindowsPowerShell\Microsoft.PowerShell_profile.ps1')
  Write-Stub $profileSrc (Join-Path $docs 'PowerShell\Microsoft.PowerShell_profile.ps1')

  Set-TerminalFont (Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')
  Write-Host 'ok configs linked'

  if (Test-Path $BackupDir) {
    Write-Host ''
    Write-Host "Old configs backed up to: $BackupDir"
  }
}

Write-Host '=== dotfiles install ==='
Write-Host ''

if (-not $Link) {
  Install-Mise
  Write-Host ''
  Install-Tools
  Write-Host ''
  Install-Font
  Write-Host ''
}

Link-Configs

if (Test-Command nvim) {
  Write-Host ''
  Write-Host 'Installing neovim plugins...'
  nvim --headless '+Lazy! sync' +qa
  if ($LASTEXITCODE -eq 0) {
    Write-Host 'ok plugins installed'
  } else {
    Write-Warning 'plugin install failed, run :Lazy sync inside nvim'
  }
}

Write-Host ''
Write-Host '=== Done ==='
Write-Host 'Restart your shell'
