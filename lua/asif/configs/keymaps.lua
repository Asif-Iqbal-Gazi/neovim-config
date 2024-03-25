local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-------------------------------------- Leader and Local Leader --------------------------------------

-- Set mapleader and maplocalleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Space as the leader key in Normal mode
keymap("n", "<Space>", "", opts)

-------------------------------------- Insert Mode --------------------------------------

-- Escape in Insert mode when "jk" is pressed quickly
keymap("i", "jk", "<ESC>", { nowait = true, noremap = true, silent = true })

-- Prevent changing <C-i> to <Tab> in Normal mode
keymap("n", "<C-i>", "<C-i>", opts)

-------------------------------------- Window Navigation --------------------------------------

-- Better window navigation using Alt+h/j/k/l and Alt+Tab
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", "<A-tab>", "<c-6>", opts)

-------------------------------------- Search and Navigation --------------------------------------

-- Center the screen vertically after navigation commands
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-------------------------------------- Visual Mode --------------------------------------

-- Stay in indent mode after shifting selection left or right
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-------------------------------------- Miscellaneous --------------------------------------

-- Delete and paste in Visual mode without changing the register
keymap("x", "p", [["_dP]])

-- Add LSP mouse menu items
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]

-- Popup mouse menu on right click or tab
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Move to the start/end of line in Visual mode with Alt+h and Alt+l
keymap({ "v", "o", "x" }, "<A-h>", "^", opts)
keymap({ "v", "o", "x" }, "<A-l>", "g_", opts)

-- Enable gj and gk to navigate lines visually instead of logically
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

-- Toggle wrap setting with <leader>w
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

-- Map <C-;> in terminal mode to exit insert mode
vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)
