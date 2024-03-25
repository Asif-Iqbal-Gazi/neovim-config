local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

-- Define the languages for Tree-sitter
local languages = {
  "c", "cpp", "lua", "vim", "vimdoc", "html", "css",
  "bash", "json", "java", "javascript", "python"
}

-- Configuration
function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = languages,
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M

