-- Remove 'c', 'r', and 'o' from formatoptions when entering a buffer/window
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Define custom mappings and settings for specific filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw", "Jaq", "qf", "git", "help", "man", "lspinfo", "oil",
    "spectre_panel", "lir", "DressingSelect", "tsplayground", "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

-- Quit the Vim session when entering the command-line window
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

-- Automatically balance window sizes when the Vim window is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Check for file changes when entering a buffer/window
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

-- Highlight yanked text briefly after yanking
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

-- Customize settings for specific filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Handle CursorHold event to manage snippets
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- Unlink current snippet if it's expandable or jumpable
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})
