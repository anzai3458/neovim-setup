#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Homebrew dependencies..."
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Install it first: https://brew.sh"
  exit 1
fi

brew install neovim git ripgrep fd lazygit 2>/dev/null || true
brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || true

echo "==> Installing Rust toolchain..."
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  source "$HOME/.cargo/env"
fi
rustup component add rust-analyzer 2>/dev/null || true

echo "==> Linking Neovim config..."
NVIM_CONFIG="$HOME/.config/nvim"
if [ -e "$NVIM_CONFIG" ] && [ ! -L "$NVIM_CONFIG" ]; then
  echo "  Backing up existing config to $NVIM_CONFIG.bak"
  mv "$NVIM_CONFIG" "$NVIM_CONFIG.bak"
fi
ln -sfn "$REPO_DIR" "$NVIM_CONFIG"
echo "  Linked $NVIM_CONFIG -> $REPO_DIR"

echo "==> Linking tmux config..."
TMUX_CONF="$HOME/.tmux.conf"
if [ -e "$TMUX_CONF" ] && [ ! -L "$TMUX_CONF" ]; then
  echo "  Backing up existing config to $TMUX_CONF.bak"
  mv "$TMUX_CONF" "$TMUX_CONF.bak"
fi
ln -sfn "$REPO_DIR/tmux.conf" "$TMUX_CONF"
echo "  Linked $TMUX_CONF -> $REPO_DIR/tmux.conf"

# Source tmux config if tmux is installed
if command -v tmux &>/dev/null; then
  echo "==> Sourcing tmux config..."
  tmux source "$TMUX_CONF" 2>/dev/null && echo "  tmux config sourced successfully." || echo "  Could not source tmux config (tmux may not be running)."
else
  echo "==> Installing tmux..."
  brew install tmux 2>/dev/null || true
  if command -v tmux &>/dev/null; then
    echo "==> Sourcing tmux config..."
    tmux source "$TMUX_CONF" 2>/dev/null && echo "  tmux config sourced successfully." || echo "  Could not source tmux config (tmux may not be running)."
  fi
fi

echo ""
echo "Done! Open nvim to complete plugin installation."
echo "Remember to set your terminal font to 'JetBrainsMono Nerd Font'."
