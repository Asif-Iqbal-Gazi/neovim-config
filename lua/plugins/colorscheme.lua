local M = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

-- Configuration
function M.config()
    vim.cmd.colorscheme("default")
    require("catppuccin").setup({
        flavour = "auto",
        background = {
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true,
        float = {
            transparent = true,
            solid = false,
        },
        show_end_of_buffer = false,
        term_colors = true,
        color_overrides = {},
        highlight_overrides = {
            mocha = function(mocha_colors)
                return { LineNr = { fg = mocha_colors.overlay2, }, }
            end,
        },
        auto_integrations = true,
        integrations = {
            blink_cmp = true,
            fzf = true,
            treesitter = true,
            mason = true,
            indent_blankline = {
                enabled = true,
                scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = true,
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
            which_key = true,
        },
    })

    vim.cmd.colorscheme("catppuccin")
end

return M
