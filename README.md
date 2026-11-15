# Dev environment

Minimal dotfiles for Linux servers, macOS and Windows. No root, no bloat, one command.

## What's inside

| Tool | Version | Purpose |
|------|---------|---------|
| neovim | latest | editor |
| tmux | latest | terminal multiplexer (Linux and macOS) |
| fzf | latest | fuzzy finder |
| ripgrep | latest | grep replacement |
| fd | latest | find replacement |
| lazygit | latest | git TUI |
| uv | latest | python version + tool manager |
| zig | latest | C compiler for treesitter parsers (Windows only) |

## Quick start

Linux, macOS, WSL:

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./install.sh
```

Windows (PowerShell, no admin needed):

```powershell
git clone <this-repo> $HOME\dotfiles
cd $HOME\dotfiles
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

That's it. Restart your shell.

## What the installer does

1. Installs mise (`~/.local/bin/` on Linux and macOS, winget on Windows) if not present
2. Installs all tools via `mise install`
3. Links configs into place (symlinks, or junctions on Windows) and writes a shell rc stub that sources this repo
4. Backs up any existing configs to `~/.dotfiles-backup-<timestamp>/`
For Neovim icons in JupyterLab, install/select a Nerd Font on the local client. Installing it only on a remote server does not change browser rendering.

## Structure

```
nvim/        → ~/.config/nvim/        (Windows: %LOCALAPPDATA%\nvim)
tmux/        → ~/.tmux.conf           (Linux and macOS)
zsh/, bash/  → sourced from ~/.zshrc or ~/.bashrc
powershell/  → sourced from $PROFILE  (Windows)
mise/        → ~/.config/mise/
install.sh   Linux, macOS, WSL
install.ps1  Windows
```

## Adding a tool

1. Add to `mise/config.toml`
2. Run `mise install`

## Updating

```bash
cd ~/dotfiles
git pull
mise install          # picks up new tools
./install.sh --link   # re-symlink if configs moved
```

On Windows the last step is `.\install.ps1 -Link`.
