local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdate" },
  build = ":TSUpdate",
}

-- Define the languages for Tree-sitter
local languages = {
  "c",
  "cpp",
  "lua",
  "vim",
  "vimdoc",
  "html",
  "css",
  "bash",
  "json",
  "java",
  "javascript",
  "python",
  "markdown",
  "markdown_inline",
}

-- Configuration
function M.config()
  local treesitter_configs = require("nvim-treesitter.configs")
  treesitter_configs.setup({
    ensure_installed = languages,
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
