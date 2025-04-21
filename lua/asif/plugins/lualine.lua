local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = { ignore_focus = { "NvimTree" } },
        extensions = { "quickfix", "man", "oil", "fzf", "fugitive" },

    }
}

return M
