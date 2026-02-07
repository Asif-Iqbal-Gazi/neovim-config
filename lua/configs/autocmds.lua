local autocmd = vim.api.nvim_create_autocmd

----------------------------------------------------------------------------------------------------
-- ✂️  General Editing Behavior
----------------------------------------------------------------------------------------------------

-- Disable auto-commenting on newline (removes 'c', 'r', and 'o' from formatoptions)
autocmd("BufWinEnter", {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

-- Check for external file changes when entering a buffer/window
autocmd("BufWinEnter", {
    pattern = { "*" },
    callback = function()
        vim.cmd("checktime")
    end,
})

----------------------------------------------------------------------------------------------------
-- 🪟 UI / Window Management
----------------------------------------------------------------------------------------------------

-- Automatically equalize window sizes when resizing Neovim
autocmd("VimResized", {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

----------------------------------------------------------------------------------------------------
-- 🔎 Visual Feedback
----------------------------------------------------------------------------------------------------

-- Highlight text on yank (copy)
autocmd("TextYankPost", {
    callback = function()
        -- vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
        vim.hl.on_yank({ higroup = "Visual", timeout = 40 })
    end,
})

----------------------------------------------------------------------------------------------------
-- 📝 Filetype-specific Settings
----------------------------------------------------------------------------------------------------

-- Enable line wrapping and spell check for writing filetypes
autocmd("FileType", {
    pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Close specific plugin/special buffers with `q`
-- Optional: remove if using plugin-specific setups that already map `q`
autocmd("FileType", {
    pattern = {
        "netrw",
        "Jaq",
        "qf",
        "git",
        "help",
        "man",
        "lspinfo",
        "oil",
        "spectre_panel",
        "lir",
        "DressingSelect",
        "tsplayground",
    },
    callback = function()
        vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
    end,
})

----------------------------------------------------------------------------------------------------
-- ⛔ Optional / Commented
----------------------------------------------------------------------------------------------------

-- -- Prevent accidentally opening CmdWin (recommended alternative to auto-quit)
-- vim.keymap.set("n", "q:", "<Nop>", { noremap = true, silent = true })

-- -- Snippet unlink logic (for advanced Luasnip users only)
-- autocmd("CursorHold", {
--   callback = function()
--     local ok, luasnip = pcall(require, "luasnip")
--     if not ok then return end
--     if luasnip.expand_or_jumpable() then
--       require("luasnip").unlink_current()
--     end
--   end,
-- })
