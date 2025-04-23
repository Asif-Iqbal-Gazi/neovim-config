local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = { theme = "catppuccin", ignore_focus = { "NvimTree" } },
        extensions = { "quickfix", "man", "oil", "fzf", "lazy", "fugitive" },
    },
}

return M
