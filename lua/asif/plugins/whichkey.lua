local M = { "folke/which-key.nvim" }

-- Define key mappings
local keymappings = {
  { "<leader>q",  "<cmd>confirm q<CR>",         desc = "Quit" },
  { "<leader>h",  "<cmd>nohlsearch<CR>",        desc = "NOHL" },
  { "<leader>;",  "<cmd>tabnew | terminal<CR>", desc = "Term" },
  { "<leader>v",  "<cmd>vsplit<CR>",            desc = "Split" },

  { "<leader>d",  group = "Debug" },
  { "<leader>f",  group = "Find" },
  { "<leader>g",  group = "Git" },
  { "<leader>l",  group = "LSP" },
  { "<leader>p",  group = "Plugins" },
  { "<leader>t",  group = "Test" },

  { "<leader>a",  group = "Tab" },
  { "<leader>an", "<cmd>$tabnew<CR>",           desc = "New Empty Tab" },
  { "<leader>aN", "<cmd>tabnew %<CR>",          desc = "New Tab" },
  { "<leader>ao", "<cmd>tabonly<CR>",           desc = "Only" },
  { "<leader>ah", "<cmd>-tabmove<CR>",          desc = "Move Left" },
  { "<leader>al", "<cmd>+tabmove<CR>",          desc = "Move Right" },

  { "<leader>T",  group = "Treesitter" },
}

-- Configuration
function M.config()
  local which_key = require("which-key")
  which_key.setup({
    win = {
      border = "rounded",    -- none, single, double, shadow
      position = "bottom",   -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,          -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000,         -- positive value to position WhichKey above other floating windows.
    },
    disable = { buftypes = {}, filetypes = { "TelescopePrompt" } },
  })

  -- Register key mappings
  local wk = require("which-key")

  wk.add(keymappings)
end

return M
