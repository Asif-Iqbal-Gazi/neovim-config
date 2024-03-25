local M = { "nvim-tree/nvim-tree.lua", event = "VeryLazy" }

-- Key Mapping Settings
local keymappings = { ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "NvimTree" } }

-- Configuration
function M.config()
  local wk = require("which-key")
  wk.register(keymappings)

  local icons = require("asif.configs.icons")

  require("nvim-tree").setup {
    sync_root_with_cwd = true,
    diagnostics = { enable = true },
    view = { relativenumber = true },
    renderer = { root_folder_label = ":t" },
    update_focused_file = { enable = true },
    actions = { open_file = { resize_window = true } }
  }
end

return M

