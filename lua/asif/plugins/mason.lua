local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

-- Define servers outside of the function
local servers = { "html", "clangd", "lua_ls", "jsonls", "pyright", "ts_ls" }

-- Configuration
function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌",
      },
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })
end

return M
