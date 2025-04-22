local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig",
        "saghen/blink.cmp",
        "folke/neodev.nvim"
    },
    keys = {
        -- Code Actions, Rename & Format
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
        { "<leader>li", "<cmd>LspInfo<cr>",                       desc = "Code LSP Info" },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",      desc = "Code Rename Symbol" },
        {
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
            desc = "Format",
        },

        -- Diagnostics
        { "<leader>ldd", "<cmd>FzfLua diagnostics_document<cr>",     desc = "Find Document Diagnostics" },
        { "<leader>ldw", "<cmd>FzfLua diagnostics_workspace<cr>",    desc = "Find Workspace Diagnostics" },
        { "<leader>lj",  "<cmd>lua vim.diagnostic.goto_next()<cr>",  desc = "Next Diagnostic" },
        { "<leader>lk",  "<cmd>lua vim.diagnostic.goto_prev()<cr>",  desc = "Previous Diagnostic" },
        { "<leader>lq",  "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostics Quickfix" },

        -- Inlay Hints & CodeLens
        {
            "<leader>lh",
            "<cmd>lua require('asif.plugins.lspconfig').toggle_inlay_hints()<cr>",
            desc = "Toggle Inlay Hints",
        },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",        desc = "CodeLens Action" },

        -- Info & Rename

        -- Symbols
        { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>",       desc = "Find Document Symbols" },
        { "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Find Workspace Symbols" },
    }
}

-- Function to set keymaps for LSP features
local function set_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymaps = {
        -- gd = "<cmd>lua vim.lsp.buf.definition()<CR>",     -- Go to definition
        -- gD = "<cmd>lua vim.lsp.buf.declaration()<CR>",    -- Go to declaration
        -- gI = "<cmd>lua vim.lsp.buf.implementation()<CR>", -- Go to implementation
        -- gr = "<cmd>lua vim.lsp.buf.references()<CR>",     -- Find references
        gr = "<cmd>FzfLua lsp_references<CR>",           -- Show References
        gd = "<cmd>FzfLua lsp_definitions<CR>",          -- Show Definition
        gD = "<cmd>FzfLua lsp_declarations<CR>",         -- Show Declarations
        gI = "<cmd>FzfLua lsp_implementations<CR>",      -- Show Implementations
        gl = "<cmd>lua vim.diagnostic.open_float()<CR>", -- Show diagnostics
        K = "<cmd>lua vim.lsp.buf.hover()<CR>",          -- Show documentation
    }
    for key, cmd in pairs(keymaps) do
        vim.api.nvim_buf_set_keymap(bufnr, "n", key, cmd, opts)
    end
end

-- Function to run when LSP attaches to a buffer
M.on_attach = function(client, bufnr)
    set_keymaps(bufnr)

    -- Enable inlay hints if supported
    if vim.fn.has("nvim-0.10") == 1 and client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- -- Auto-format on save if supported
    -- if client.supports_method("textDocument/formatting") then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.format({ async = false, bufnr = bufnr })
    --     end,
    --   })
    -- end
end

-- Function to disable semantic tokens if supported
M.on_init = function(client, _)
    if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

-- Toggle inlay hints manually
M.toggle_inlay_hints = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.fn.has("nvim-0.10") == 1 then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
    end
end

local blink = require("blink.cmp")
M.capabilities =
    vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities() or {})
M.capabilities.offsetEncoding = { "utf-16" }
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    },
}

-- LSP configuraion setup function
function M.config()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local lspconfig = require("lspconfig")
    local icons = require("asif.configs.icons")

    -- Configure Mason UI
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



    -- Configure diagnostic settings
    vim.diagnostic.config({
        -- Define LSP diagnostic signs
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = "Error",
                [vim.diagnostic.severity.WARN] = "Warn",
                [vim.diagnostic.severity.INFO] = "Info",
                [vim.diagnostic.severity.HINT] = "Hint",
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            --source = "always",
            header = "",
            prefix = "",
        },
    })

    -- Set default border style for LSP UI windows
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- Define the list of LSP servers to be installed
    local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "jdtls", "pyright", "ruff" }

    -- Ensure mason-lspconfig install our server
    mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
    })

    -- Loop through each server and configure it
    for _, server in ipairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            on_init = M.on_init,
        }

        -- Attempt to load additional settings for specific servers
        local require_ok, settings = pcall(require, "asif.config.lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", opts, settings)
        end

        -- Setup Neovim development environment for Lua LSP
        if server == "lua_ls" then
            require("neodev").setup({})
        end

        -- Apply LSP configuration for the server
        lspconfig[server].setup(opts)
    end
end

return M
