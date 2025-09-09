local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        win = {
            border = "rounded",       -- "none", "single", "double", "shadow"
            padding = { 1, 2, 1, 2 }, -- top, right, bottom, left
            wo = {
                winblend = 0,         -- 0 = fully opaque, 100 = fully transparent
            },
            zindex = 1000,            -- position WhichKey above other floating windows
        },
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
        spec = {
            { "<leader>q",  "<cmd>confirm q<CR>",                         desc = "Quit" },
            { "<leader>h",  "<cmd>nohlsearch<CR>",                        desc = "NOHL" },
            { "<leader>;",  "<cmd>tabnew | terminal<CR>",                 desc = "Term" },
            { "<leader>v",  "<cmd>vsplit<CR>",                            desc = "Split" },
            { "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end, desc = "Toggle Word Wrap" },

            { "<leader>d",  group = "Debug" },
            { "<leader>f",  group = "Find" },
            { "<leader>g",  group = "LSP" },

            { "<leader>a",  group = "Tab" },
            { "<leader>an", "<cmd>$tabnew<CR>",                           desc = "New Empty Tab" },
            { "<leader>aN", "<cmd>tabnew %<CR>",                          desc = "New Tab" },
            { "<leader>ao", "<cmd>tabonly<CR>",                           desc = "Only" },
            { "<leader>ah", "<cmd>-tabmove<CR>",                          desc = "Move Left" },
            { "<leader>al", "<cmd>+tabmove<CR>",                          desc = "Move Right" },

            { "<leader>T",  group = "Treesitter" },
        },
    },
}

return M
