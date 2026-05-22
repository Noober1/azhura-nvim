# azhura-nvim

Konfigurasi Neovim personal berbasis [lazy.nvim](https://github.com/folke/lazy.nvim) dengan LSP, AI completion, dan navigasi IJKL.

## Persyaratan

- Neovim 0.11+
- Git
- Node.js (untuk Copilot & beberapa LSP)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (untuk Telescope live grep)

## Instalasi

```bash
# Linux / macOS
git clone https://github.com/Noober1/azhura-nvim.git ~/.config/nvim

# Windows (PowerShell)
git clone https://github.com/Noober1/azhura-nvim.git "$env:LOCALAPPDATA\nvim"
```

Buka Neovim — lazy.nvim akan otomatis install semua plugin.

## Aktivasi Copilot

Setelah plugin terinstall, jalankan:

```
:Copilot auth
```

Ikuti instruksi di browser untuk login ke akun GitHub.

## Plugin Utama

| Plugin | Fungsi |
|--------|--------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + Mason | LSP & language server |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) + copilot-cmp | AI code completion |
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Auto-format (Prettier) |
| [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |

## Navigasi

Konfigurasi ini menggunakan layout **IJKL** sebagai pengganti HJKL.

| Key | Aksi |
|-----|------|
| `i` | Naik |
| `k` | Turun |
| `j` | Kiri |
| `l` | Kanan |
| `I` | Naik 5 baris |
| `K` | Turun 5 baris |
| `J` | Mundur satu kata |
| `L` | Maju satu kata |
| `a` | Insert mode (pengganti `i`) |
| `ii` | Keluar insert mode (pengganti `Esc`) |

## Keymaps Penting

| Key | Aksi |
|-----|------|
| `<Space>ff` | Cari file |
| `<Space>fg` | Live grep |
| `<Space>fb` | Daftar buffer |
| `-` | Buka file explorer |
| `<Space>xx` | Toggle diagnostics (Trouble) |
| `<Space>ct` | Buka terminal Claude Code |
| `<Space>qs` | Restore session |
| `<C-u>` / `<C-d>` | Scroll setengah halaman |

## LSP yang Tersedia

- TypeScript / JavaScript (`ts_ls`)
- CSS / SCSS (`cssls`)
- JSON (`jsonls`)
- Markdown (`marksman`)
- Lua (`lua_ls`)
- Tailwind CSS (`tailwindcss`)
- Emmet (`emmet_ls`)
