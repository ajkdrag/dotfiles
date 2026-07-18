# Remote dev environment

Minimal dotfiles for servers. No root, no bloat, one command.

## What's inside

| Tool | Version | Purpose |
|------|---------|---------|
| neovim | latest | editor |
| tmux | latest | terminal multiplexer |
| fzf | latest | fuzzy finder |
| ripgrep | latest | grep replacement |
| fd | latest | find replacement |
| lazygit | latest | git TUI |
| uv | latest | python version + tool manager |
| node | lts | required by some neovim plugins |

## Quick start

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./install.sh
```

That's it. Restart your shell.

## What install.sh does

1. Installs mise to `~/.local/bin/` (if not present)
2. Installs all tools via `mise install`
3. Symlinks configs into `~/.config/`
4. Backs up any existing configs to `~/.dotfiles-backup-<timestamp>/`
5. Installs JetBrainsMono Nerd Font in the user font directory

For Neovim icons in JupyterLab, select `JetBrainsMono Nerd Font` in the
browser machine's JupyterLab terminal settings. Installing it only on a
remote server does not change the font used by a local browser.

## Structure

```
nvim/     → ~/.config/nvim/
tmux/     → ~/.tmux.conf
zsh/      → ~/.zshrc
mise/     → ~/.config/mise/
install.sh
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
