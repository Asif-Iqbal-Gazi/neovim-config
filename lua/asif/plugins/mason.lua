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
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌",
      },
    },
  })

  mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
  })
end

return M
