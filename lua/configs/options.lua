local g = vim.g
local opt = vim.opt

--------------------------------------------------------------------------------
-- 📦 Plugin & Built-in Behavior
--------------------------------------------------------------------------------

-- Disable netrw (useful if using a modern file explorer like nvim-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.netrw_banner = 0 -- Hide netrw banner
g.netrw_mouse = 2 -- Enable mouse support in netrw

-- Enable Nerd Font support (used by plugins like lualine, telescope)
g.have_nerd_font = true

--------------------------------------------------------------------------------
-- 🧭 UI Settings
--------------------------------------------------------------------------------

-- Status line
opt.laststatus = 3 -- Global statusline
opt.showmode = false -- Don't show mode (handled by statusline plugin)

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false -- Disable old ruler display

-- Cursor
opt.cursorline = true
opt.cursorlineopt = "both" -- Highlight both number and line

-- Sign column
opt.signcolumn = "yes" -- Always show sign column

-- Fill characters
opt.fillchars = { eob = " " } -- Remove ~ at end of buffer

-- GUI
opt.termguicolors = true -- Enable true color support

-- Scroll offset
opt.scrolloff = 10 -- Minimum lines above/below cursor

--------------------------------------------------------------------------------
-- 🧠 Behavior & UX
--------------------------------------------------------------------------------

-- Mouse
opt.mouse = "a" -- Enable mouse in all modes

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Timeouts
opt.timeoutlen = 300 -- Faster mappings

-- Completion popup
opt.completeopt = { "menuone", "noselect" }
opt.pumheight = 10
opt.pumblend = 10 -- Transparency

-- Short messages
opt.shortmess:append("sI") -- Disable intro message

-- Word navigation
opt.whichwrap:append("<>[]hl") -- Move to next/prev line with h/l at start/end

-- Clipboard
opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- Keyword definition
-- vim.cmd([[set iskeyword+=-]]) -- Treat dash-separated words as one
opt.iskeyword:append("-") -- Treat dash-separated words as one

-- Show live preview of :substitute
opt.inccommand = "split"

--------------------------------------------------------------------------------
-- 🌐 Global-only vim.o Settings
--------------------------------------------------------------------------------

vim.o.winborder = "rounded" -- Rounded borders for floating windows
--vim.o.winhighlight = "Normal:Normal,FloatBorder:FloatBorder" -- Cleaner float UI (optional)

--------------------------------------------------------------------------------
-- 🔍 Search
--------------------------------------------------------------------------------

opt.ignorecase = true -- Case insensitive search...
opt.smartcase = true -- ...unless uppercase is used

--------------------------------------------------------------------------------
-- ✍️ Editing & Formatting
--------------------------------------------------------------------------------

-- Indentation
opt.tabstop = 4 -- Number of spaces tabs count for
opt.expandtab = true -- Use spaces instead of tabs
opt.softtabstop = 4 -- Number of spaces inserted instead of TAB character
opt.shiftwidth = 4 -- Number of spaces inserted when indenting
opt.smarttab = true
opt.smartindent = true -- syntax aware indentations for newline inserts
opt.autoindent = true
opt.breakindent = true

-- Whitespace characters
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--------------------------------------------------------------------------------
-- 🪄 Folding
--------------------------------------------------------------------------------

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true        -- Enable folding by default
vim.opt.foldlevel = 99           -- Open all folds by default
vim.opt.foldlevelstart = 99      -- Start with all folds open


--------------------------------------------------------------------------------
-- 💾 Files & Backups
--------------------------------------------------------------------------------

opt.swapfile = false -- Disable swapfile
opt.writebackup = false -- Disable write backup
opt.undofile = true -- Enable persistent undo
opt.updatetime = 100 -- Faster updates (good for plugins)

-- File encoding (uncomment if needed)
-- opt.fileencoding = "utf-8"
