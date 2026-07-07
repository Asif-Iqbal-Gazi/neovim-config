local M = {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
    },
}

-- Define servers outside of the function
local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "ruff", "jdtls", "rust_analyzer" }

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
        -- We enable servers ourselves via vim.lsp.enable() in configs/lsp.lua,
        -- so don't let mason-lspconfig also auto-enable them (avoids double-enable).
        automatic_enable = false,
    })
end

return M
