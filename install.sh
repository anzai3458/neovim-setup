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

echo ""
echo "Done! Open nvim to complete plugin installation."
echo "Remember to set your terminal font to 'JetBrainsMono Nerd Font'."
