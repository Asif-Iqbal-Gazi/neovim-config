local M = {
    'stevearc/oil.nvim',
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    keys = {
        { "-", "<cmd>Oil --float<cr>", desc = "Open Parent Directory in Oil" },
    }
}

return M
