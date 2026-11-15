# Minimal PowerShell profile. Same aliases as zsh/zshrc.
# Works in Windows PowerShell 5.1 and PowerShell 7.

# --- Path ---
$dotfilesPaths = @(
  (Join-Path $env:LOCALAPPDATA 'mise\shims'),
  (Join-Path $env:LOCALAPPDATA 'nvim-data\mason\bin')
)
foreach ($p in $dotfilesPaths) {
  if ((Test-Path $p) -and (($env:Path -split ';') -notcontains $p)) {
    $env:Path = "$p;$env:Path"
  }
}

# --- Navigation ---
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

# --- Editor ---
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias vim nvim
$env:EDITOR = 'nvim'
$env:VISUAL = 'nvim'

# --- Git ---
# gc, gp and gl are built-in aliases in PowerShell, so they are removed first.
foreach ($a in 'gc', 'gp', 'gl') {
  if (Test-Path "Alias:$a") { Remove-Item "Alias:$a" -Force }
}
function ga { git add @args }
function gc { git commit -m @args }
function gs { git status @args }
function gd { git diff @args }
function gp { git push @args }
function gl { git log --oneline -20 @args }
function gco { git checkout @args }
function gcb { git checkout -b @args }

# --- FZF ---
if (Get-Command fzf -ErrorAction SilentlyContinue) {
  $env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
  $env:FZF_CTRL_T_COMMAND = $env:FZF_DEFAULT_COMMAND
  $env:FZF_DEFAULT_OPTS = '--height 40% --layout=reverse --border'
}

# --- Prompt ---
# user@host:cwd (git branch)
function prompt {
  $cwd = (Get-Location).Path.Replace($HOME, '~')
  $branch = git branch --show-current 2>$null
  Write-Host "$env:USERNAME@$env:COMPUTERNAME" -NoNewline -ForegroundColor Green
  Write-Host ':' -NoNewline
  Write-Host $cwd -NoNewline -ForegroundColor Blue
  if ($branch) { Write-Host " ($branch)" -NoNewline -ForegroundColor Yellow }
  return ' > '
}
