local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--------------------------------------------------------------------------------
-- 🌟 Leader Key Configuration
--------------------------------------------------------------------------------
-- Set <Space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- ✏️ Insert Mode Shortcuts
--------------------------------------------------------------------------------
-- Quick escape using 'jk' in insert mode
keymap("i", "jk", "<ESC>", { nowait = true, noremap = true, silent = true })

-- Prevent <C-i> being interpreted as <Tab>
keymap("n", "<C-i>", "<C-i>", opts)

--------------------------------------------------------------------------------
-- 🪟 Window Navigation
--------------------------------------------------------------------------------
-- Move between windows using Alt + hjkl
-- NOTE: tmux-navigator takes care of this for split windows but not for quickfix window)
-- NOTE: tmux-navigator takes care of this, with latest update)
-- keymap("n", "<A-h>", "<C-w>h", opts)
-- keymap("n", "<A-j>", "<C-w>j", opts)
-- keymap("n", "<A-k>", "<C-w>k", opts)
-- keymap("n", "<A-l>", "<C-w>l", opts)

-- Switch between alternate buffers using Alt+Tab
keymap("n", "<A-tab>", "<c-6>", opts)

--------------------------------------------------------------------------------
-- 🔎 Navigation + Centering
--------------------------------------------------------------------------------
-- Keep cursor centered on search and page scroll
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-f>", "<C-f>zz", opts)
keymap("n", "<C-b>", "<C-b>zz", opts)

--------------------------------------------------------------------------------
-- 🖱️ Visual Mode Improvements
--------------------------------------------------------------------------------
-- Stay in visual mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move to start/end of visual line with Alt+h/l
keymap({ "v", "o", "x" }, "<A-h>", "^", opts)
keymap({ "v", "o", "x" }, "<A-l>", "g_", opts)

--------------------------------------------------------------------------------
-- 🪶 Text Editing Quality of Life
--------------------------------------------------------------------------------
-- Do not copy replaced text in visual paste
keymap("x", "p", [["_dP]])

-- Navigate by visual lines (e.g., with softwrap)
-- keymap({ "n", "x" }, "j", "gj", opts)
-- keymap({ "n", "x" }, "k", "gk", opts)

--------------------------------------------------------------------------------
-- 🔁 Terminal Mode Enhancements
--------------------------------------------------------------------------------
-- Exit terminal insert mode using <C-;>
vim.api.nvim_set_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

--------------------------------------------------------------------------------
-- 🧪 Miscellaneous
--------------------------------------------------------------------------------
-- Add extra mappings here
