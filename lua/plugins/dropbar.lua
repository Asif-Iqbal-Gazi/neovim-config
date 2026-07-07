local M = {
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Not lazy-loaded: dropbar needs to set the winbar for the first buffer too.
    opts = {},
    keys = {
        -- Interactive pick mode: jump to a symbol via the breadcrumb menu
        { "<leader>b", function() require("dropbar.api").pick() end, desc = "Breadcrumb Pick" },
    },
}

return M
