local g = vim.g
local opt = vim.opt

-------------------------------------- globals -----------------------------------------
-- Disable netrw at the very start
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1


-------------------------------------- options -----------------------------------------
-- Status Line
opt.laststatus = 3
opt.showmode = false

-- Clipboard
opt.clipboard = "unnamedplus"

-- Cursor
opt.cursorline = true
opt.cursorlineopt = "both"

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Fill characters
opt.fillchars = { eob = " " }

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Mouse
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- Nvim Intro
opt.shortmess:append "sI"

-- Sign Column
opt.signcolumn = "yes"

-- Splitting
opt.splitbelow = true
opt.splitright = true

-- Timeout
opt.timeoutlen = 400

-- Undo
opt.undofile = true

-- Update time
opt.updatetime = 100

-- Which Wrap
opt.whichwrap:append "<>[]hl"

-- GUI Colors
opt.termguicolors = true

-- Backup
opt.writebackup = false

-- Completion
opt.completeopt = { "menuone", "noselect" }

-- Popup Menu
opt.pumheight = 10
opt.pumblend = 10

-- Swapfile
opt.swapfile = false

-- File Encoding
-- opt.fileencoding = "utf-8" -- uncomment if needed

-- Additional Settings
vim.cmd [[set iskeyword+=-]]

-- Netrw
g.netrw_banner = 0
g.netrw_mouse = 2

