#!/usr/bin/env bash
set -e

echo "==> Removing Neovim config symlink..."
NVIM_CONFIG="$HOME/.config/nvim"
if [ -L "$NVIM_CONFIG" ]; then
  rm "$NVIM_CONFIG"
  echo "  Removed $NVIM_CONFIG"
elif [ -e "$NVIM_CONFIG" ]; then
  echo "  $NVIM_CONFIG is not a symlink — skipping (remove manually if needed)"
else
  echo "  $NVIM_CONFIG not found, skipping"
fi

echo "==> Removing Neovim data, state, and cache..."
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.cache/nvim"
echo "  Removed ~/.local/share/nvim, ~/.local/state/nvim, ~/.cache/nvim"

echo "==> Uninstalling Neovim..."
if brew list neovim &>/dev/null; then
  brew uninstall neovim
else
  echo "  Neovim not installed via Homebrew, skipping"
fi

# Optional removals — prompt the user
echo ""
read -r -p "Remove lazygit? [y/N] " reply
if [[ "$reply" =~ ^[Yy]$ ]]; then
  brew uninstall lazygit 2>/dev/null || echo "  lazygit not installed, skipping"
fi

read -r -p "Remove JetBrainsMono Nerd Font? [y/N] " reply
if [[ "$reply" =~ ^[Yy]$ ]]; then
  brew uninstall --cask font-jetbrains-mono-nerd-font 2>/dev/null || echo "  Font not installed, skipping"
fi

echo "==> Removing tmux config symlink..."
TMUX_CONF="$HOME/.tmux.conf"
if [ -L "$TMUX_CONF" ]; then
  rm "$TMUX_CONF"
  echo "  Removed $TMUX_CONF"
  # Restore backup if it exists
  if [ -e "$TMUX_CONF.bak" ]; then
    mv "$TMUX_CONF.bak" "$TMUX_CONF"
    echo "  Restored backup to $TMUX_CONF"
  fi
elif [ -e "$TMUX_CONF" ]; then
  echo "  $TMUX_CONF is not a symlink — skipping (remove manually if needed)"
else
  echo "  $TMUX_CONF not found, skipping"
fi

echo ""
echo "Done. ripgrep and fd were kept (commonly used by other tools)."
echo "Rust/rustup was kept — remove manually with 'rustup self uninstall' if needed."
