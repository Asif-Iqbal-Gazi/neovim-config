local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
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
}

-- Configuration
function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = languages,
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
