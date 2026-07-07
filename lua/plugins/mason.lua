local M = {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
    },
}

-- Define servers outside of the function
local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "ruff", "jdtls", "rust_analyzer" }

-- Non-LSP tools (formatters + treesitter CLI). mason-lspconfig's
-- ensure_installed only handles LSP servers, so these are installed
-- directly through the mason registry below.
local tools = { "prettierd", "stylua", "shfmt", "tree-sitter-cli" }

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

    -- Ensure non-LSP tools are installed (idempotent, runs once the registry loads).
    local registry = require("mason-registry")
    registry.refresh(function()
        for _, name in ipairs(tools) do
            local ok, pkg = pcall(registry.get_package, name)
            if ok and not pkg:is_installed() then
                pkg:install()
            end
        end
    end)
end

return M
