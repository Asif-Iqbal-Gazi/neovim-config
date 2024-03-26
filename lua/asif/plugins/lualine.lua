local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}

-- Configuration
function M.config()
  require('lualine').setup {
    options = { ignore_focus = { "NvimTree" } },
    extensions = { "quickfix", "man", "fugitive" }
  }
end

return M
