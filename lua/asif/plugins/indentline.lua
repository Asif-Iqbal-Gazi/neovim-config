local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
}

function M.config()
  local icons = require "asif.configs.icons"

  local hl_name_list = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterBlue",
    "RainbowDelimiterCyan",
    "RainbowDelimiterViolet",
  }

  require("ibl").setup {
    scope = {
      enabled = true,
      show_start = false,
      highlight = hl_name_list,
    },
  }

  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
