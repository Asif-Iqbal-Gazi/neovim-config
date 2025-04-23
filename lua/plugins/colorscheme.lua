local M = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

-- Configuration
function M.config()
    vim.cmd.colorscheme("default")
    require("catppuccin").setup({
        flavour = "auto",
        transparent_background = true,
        integrations = {
            cmp = true,
            nvimtree = true,
            treesitter = true,
            mason = true,
            indent_blankline = {
                enabled = false,
                scope_color = "green", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            navic = {
                enabled = true,
                custom_bg = "NONE", -- "lualine" will set background to mantle
            },
            telescope = {
                enabled = true,
                -- style = "nvchad"
            },
            which_key = true,
        },
    })

    vim.cmd.colorscheme("catppuccin")
end

return M
