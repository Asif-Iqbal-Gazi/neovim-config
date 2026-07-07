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
            filetypes = {},
        },
        spec = {
            { "<leader>q",  "<cmd>confirm q<CR>",                         desc = "Quit" },
            { "<leader>h",  "<cmd>nohlsearch<CR>",                        desc = "NOHL" },
            { "<leader>;",  "<cmd>tabnew | terminal<CR>",                 desc = "Term" },
            { "<leader>v",  "<cmd>vsplit<CR>",                            desc = "Split" },

            { "<leader>f",  group = "Find" },

            { "<leader>l",  group = "LSP" },

            -- Relabel built-in default LSP maps in the which-key popup so they
            -- read consistently even before an LSP attaches (the fzf overrides
            -- in configs/lsp.lua only set buffer-local labels on attach).
            { "grn",        desc = "Rename Symbol" },
            { "gra",        desc = "Code Action",                         mode = { "n", "x" } },
            { "grr",        desc = "[G]oto [R]eferences" },
            { "gri",        desc = "[G]oto [I]mplementation" },
            { "grt",        desc = "[G]oto [T]ype Definition" },
            { "gO",         desc = "[G]oto Document Symbols" },
            { "grx",        desc = "Run CodeLens" },

            { "<leader>t",  group = "Toggle" },
            { "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end, desc = "Word Wrap" },

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
