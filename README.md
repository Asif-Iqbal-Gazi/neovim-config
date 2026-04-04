# 🛠️ My Neovim Config

A modular and minimal Neovim configuration tailored for performance, modern UX, and power-user features — all built on top of Neovim **0.12+**.

> ✨ Designed for developers who want clarity, speed, and control.

---

## 📦 Requirements

Before using this config, make sure the following are installed:

### 🧠 Neovim
- Version: **0.12.0 or higher**
- [Installation guide](https://github.com/neovim/neovim/wiki/Installing-Neovim)

### 🔍 Dependencies
These are required for some plugins to work correctly:

- [ripgrep](https://github.com/BurntSushi/ripgrep): for fast file searching
- [fzf](https://github.com/junegunn/fzf): fuzzy finder engine

You can install both via your package manager. Example (for macOS with Homebrew):

```sh
brew install ripgrep fzf
```
Or on Ubuntu:
```sh
sudo apt install ripgrep fzf
```
---

## 🧾 File Structure Overview

```lua
init.lua
├── launch.lua                  -- Bootstraps plugin manager and essential setup
├── configs/
│   ├── options.lua             -- Core Neovim options
│   ├── keymaps.lua             -- Global key mappings
│   ├── autocmds.lua            -- Auto commands
│   ├── lsp.lua                 -- LSP and diagnostics configuration
│   ├── lazy.lua                -- Lazy.nvim plugin manager configuration
│   └── icons.lua               -- Icon definitions used across plugins
├── lsp/
│   ├── clangd.lua              -- C/C++
│   ├── html.lua                -- HTML
│   ├── jdtls.lua               -- Java
│   ├── jsonls.lua              -- JSON
│   ├── lua_ls.lua              -- Lua
│   ├── ruff.lua                -- Python
│   ├── rust_analyzer.lua       -- Rust
│   └── ts_ls.lua               -- TypeScript/JavaScript
└── plugins/
    ├── colorscheme.lua         -- Theme and colorscheme (Catppuccin)
    ├── lualine.lua             -- Statusline setup
    ├── treesitter.lua          -- Syntax highlighting and parsing
    ├── conform.lua             -- Code formatting
    ├── oil.lua                 -- File explorer (alternative to NvimTree)
    ├── mason.lua               -- LSP server installer
    ├── whichkey.lua            -- Keymap discovery
    ├── showkeys.lua            -- Key press feedback
    ├── blink-cmp.lua           -- Completion engine
    ├── fzf.lua                 -- Fuzzy finding via fzf-lua
    ├── autopairs.lua           -- Auto-close brackets/quotes
    ├── navic.lua               -- Breadcrumb nav for LSP
    ├── breadcrumbs.lua         -- Enhanced winbar breadcrumbs
    ├── comment.lua             -- Commenting support
    ├── indentline.lua          -- Indentation guides
    ├── colorizer.lua           -- Color preview in code
    ├── tmux-navigator.lua      -- Tmux window navigation
    ├── lazydev.lua             -- Lua development support
    ├── hardtime.lua            -- Vim muscle memory trainer
    └── venn.lua                -- ASCII diagram drawing
```

---

## 🚀 Getting Started

1. Clone this config into the Neovim config directory:
```sh
git clone https://github.com/Asif-Iqbal-Gazi/neovim-config.git ~/.config/nvim
```
2. Open Neovim. Plugins will be automatically installed via `lazy.nvim` on launch.
```sh
nvim
```
3. You're good to go! Explore your new setup, and start coding ✨

---

## 🎯 Goals of This Config
- **Fast startup** with Lazy loading 
- **Rich LSP support** out of the box 
- **Modern UI** using treesitter, colorizer, breadcrumbs 
- **Developer productivity** via keymaps, commenting, formatting, fuzzy finders 

---

## 🤝 Credits
Built with ❤️ using the Neovim ecosystem and these amazing open-source tools: 
- [lazy.nvim](https://github.com/folke/lazy.nvim) 
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) 
- [mason.nvim](https://github.com/williamboman/mason.nvim) 
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) 

---

## 🐛 Issues / Feedback
Feel free to open a PR or issue on the repository if you have ideas, bug reports, or improvements! 

---
