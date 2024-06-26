local M = { "folke/which-key.nvim" }

-- Define key mappings
local keymappings = {
  q = { "<cmd>confirm q<CR>", "Quit" },
  h = { "<cmd>nohlsearch<CR>", "NOHL" },
  [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
  v = { "<cmd>vsplit<CR>", "Split" },
  --  b = { name = "Buffers" },
  d = { name = "Debug" },
  f = { name = "Find" },
  g = { name = "Git" },
  l = { name = "LSP" },
  p = { name = "Plugins" },
  t = { name = "Test" },
  a = {
    name = "Tab",
    n = { "<cmd>$tabnew<CR>", "New Empty Tab" },
    N = { "<cmd>tabnew %<CR>", "New Tab" },
    o = { "<cmd>tabonly<CR>", "Only" },
    h = { "<cmd>-tabmove<CR>", "Move Left" },
    l = { "<cmd>+tabmove<CR>", "Move Right" },
  },
  T = { name = "Treesitter" },
}

-- Configuration
function M.config()
  local which_key = require("which-key")
  which_key.setup {
    window = {
      border = "rounded",       -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000,            -- positive value to position WhichKey above other floating windows.
    },
    disable = { buftypes = {}, filetypes = { "TelescopePrompt" } },
  }

  -- Register key mappings
  which_key.register(keymappings, { mode = "n", prefix = "<leader>" })
end

return M
