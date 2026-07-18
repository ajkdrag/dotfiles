#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
LINK_ONLY=false

# --- Parse args ---
for arg in "$@"; do
  case "$arg" in
    --link) LINK_ONLY=true ;;
    --help|-h)
      echo "Usage: ./install.sh [--link]"
      echo "  (no args)  Full install: mise + tools + symlinks"
      echo "  --link     Only re-symlink configs (skip mise)"
      exit 0
      ;;
  esac
done

# --- Helper ---
backup_and_link() {
  local src="$1"
  local dst="$2"

  # If dst is already a correct symlink, skip
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  ✓ $dst (already linked)"
    return
  fi

  # Backup existing file/dir
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "  → backing up $dst"
    mv "$dst" "$BACKUP_DIR/"
  fi

  # Create parent dir if needed
  mkdir -p "$(dirname "$dst")"

  # Symlink
  ln -sf "$src" "$dst"
  echo "  ✓ $dst → $src"
}

# --- Install mise ---
install_mise() {
  if command -v mise &>/dev/null; then
    echo "✓ mise already installed: $(mise --version)"
    return
  fi

  echo "Installing mise..."
  curl -sS https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"

  if ! command -v mise &>/dev/null; then
    echo "ERROR: mise installation failed"
    exit 1
  fi
  echo "✓ mise installed: $(mise --version)"
}

# --- Install tools ---
install_tools() {
  echo "Installing tools via mise..."
  # Trust the config
  mise trust "$DOTFILES_DIR/mise/config.toml" 2>/dev/null || true
  # ponytail: skip sigstore attestation verify, corp proxies block TUF CDN
  MISE_AQUA_GITHUB_ATTESTATIONS=false mise install --cd "$DOTFILES_DIR/mise"
  echo "✓ tools installed"

  # Python via uv (fast, no compile)
  if command -v uv &>/dev/null; then
    uv python install 3.12 2>/dev/null && echo "✓ python 3.12 via uv" || true
  fi
}

install_nerd_font() {
  local font_dir archive
  case "$(uname -s)" in
    Darwin) font_dir="$HOME/Library/Fonts" ;;
    *) font_dir="$HOME/.local/share/fonts" ;;
  esac

  if find "$font_dir" -maxdepth 1 -iname '*JetBrainsMono*Nerd*' -print -quit 2>/dev/null | grep -q .; then
    echo "✓ JetBrainsMono Nerd Font already installed"
    return
  fi

  echo "Installing JetBrainsMono Nerd Font..."
  mkdir -p "$font_dir"
  archive="$(mktemp)"
  curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz -o "$archive"
  tar -xJf "$archive" -C "$font_dir" --wildcards '*.ttf'
  rm -f "$archive"
  command -v fc-cache &>/dev/null && fc-cache -f "$font_dir"
  echo "✓ JetBrainsMono Nerd Font installed"
}

# --- Symlink configs ---
link_configs() {
  echo "Linking configs..."
  backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
  backup_and_link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
  backup_and_link "$DOTFILES_DIR/mise" "$HOME/.config/mise"

  # Shell: zsh if available, bash otherwise
  if command -v zsh &>/dev/null; then
    backup_and_link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
  else
    backup_and_link "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
  fi
  echo "✓ configs linked"

  if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "Old configs backed up to: $BACKUP_DIR"
  fi
}

# --- Main ---
echo "=== dotfiles install ==="
echo ""

if [ "$LINK_ONLY" = false ]; then
  install_mise
  echo ""
  install_tools
  echo ""
  install_nerd_font
  echo ""
fi

link_configs

# Pre-install nvim plugins headlessly
if command -v nvim &>/dev/null; then
  echo ""
  echo "Installing neovim plugins..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
  echo "✓ plugins installed"
fi

echo ""
echo "=== Done ==="
if command -v zsh &>/dev/null; then
  echo "Restart your shell or run: exec zsh"
else
  echo "zsh not found. Add to ~/.bashrc: source ~/dotfiles/zsh/zshrc"
  echo "Then: source ~/.bashrc"
fi
