# neovim-setup

Personal Neovim configuration based on [LazyVim](https://www.lazyvim.org), set up for Rust and frontend (TypeScript/JavaScript/Tailwind) development.

## Features

- File explorer (Neo-tree) — `<Space>e`
- Fuzzy finder (Telescope) — `<Space>ff`, `<Space>fg`
- LSP via Mason: `rust_analyzer`, `vtsls`, `tailwindcss`
- Git UI (LazyGit) — `<Space>gg`
- Language extras: Rust, TypeScript, JSON, Tailwind CSS

## Setup on a new machine

**Prerequisites:** macOS with [Homebrew](https://brew.sh) installed.

```bash
git clone <your-github-repo-url> ~/dev/neovim-setup
cd ~/dev/neovim-setup
chmod +x install.sh
./install.sh
```

Then open `nvim` — plugins will auto-install on first launch.

Set your terminal font to **JetBrainsMono Nerd Font** for icons to render correctly.

## Key bindings

| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file explorer |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>gg` | LazyGit |
| `K` | Hover documentation (LSP) |
| `gd` | Go to definition |
| `gr` | Find references |
| `<Space>ca` | Code actions |
| `<Space>l` | Mason (manage LSP servers) |

## Uninstall

To remove Neovim and all related configuration from a machine:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This removes:
- The `~/.config/nvim` symlink
- Neovim plugin data, state, and cache (`~/.local/share/nvim`, `~/.local/state/nvim`, `~/.cache/nvim`)
- Neovim itself (via Homebrew)
- Optionally: lazygit, JetBrainsMono Nerd Font (prompted)

Not removed automatically: `ripgrep`, `fd` (commonly used by other tools), and the Rust toolchain. To remove Rust: `rustup self uninstall`.

## Customization

- Add plugins: `lua/plugins/`
- Override options: `lua/config/options.lua`
- Custom keymaps: `lua/config/keymaps.lua`
