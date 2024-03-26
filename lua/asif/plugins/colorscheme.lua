local M = { "catppuccin/nvim", }

-- Configuration
function M.config()
  vim.cmd.colorscheme "catppuccin-mocha"
  require("catppuccin").setup({

    integrations = {
      cmp = true,
      nvimtree = true,
      treesitter = true,
      mason = true,
      indent_blankline = {
        enabled = true,
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
        enabled = false,
        custom_bg = "NONE", -- "lualine" will set background to mantle
      },
      telescope = {
        enabled = true,
        -- style = "nvchad"
      },
      which_key = true
    }
  })
end

return M
