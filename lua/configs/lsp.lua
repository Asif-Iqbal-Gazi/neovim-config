-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
    callback = function(event)
        local set_keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        set_keymap("gr", "<cmd>FzfLua lsp_references<CR>", "Show References")
        set_keymap("gd", "<cmd>FzfLua lsp_definitions<CR>", "Show Definition")
        set_keymap("gD", "<cmd>FzfLua lsp_declarations<CR>", "Show Declarations")
        set_keymap("gI", "<cmd>FzfLua lsp_implementations<CR>", "Show Implementations")
        set_keymap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Implementations")
        set_keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Implementations")
        -- gd = "<cmd>lua vim.lsp.buf.definition()<CR>",     -- Go to definition
        -- gD = "<cmd>lua vim.lsp.buf.declaration()<CR>",    -- Go to declaration
        -- gI = "<cmd>lua vim.lsp.buf.implementation()<CR>", -- Go to implementation
        -- gr = "<cmd>lua vim.lsp.buf.references()<CR>",     -- Find references
        -- Code Actions, Rename & Format
        set_keymap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action")
        set_keymap("<leader>li", "<cmd>LspInfo<cr>", "Code LSP Info")
        set_keymap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Code Rename Symbol")
        set_keymap(
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
            "Format Code"
        )

        -- Diagnostics
        set_keymap("<leader>ldd", "<cmd>FzfLua diagnostics_document<cr>", "Find Document Diagnostics")
        set_keymap("<leader>ldw", "<cmd>FzfLua diagnostics_workspace<cr>", "Find Workspace Diagnostics")
        set_keymap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic")
        set_keymap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic")
        set_keymap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", "Diagnostics Quickfix")

        -- Inlay Hints & CodeLens
        --         {
        --             "<leader>lh",
        --             "<cmd>lua require('plugins.lspconfig').toggle_inlay_hints()<cr>",
        --             desc = "Toggle Inlay Hints",
        --         },
        --         { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",        desc = "CodeLens Action" },
        --
        -- Info & Rename
        --
        -- Symbols
        set_keymap("<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", "Find Document Symbols")
        set_keymap("<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", "Find Workspace Symbols")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "my-lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            set_keymap("<leader>lh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle Inlay Hints")
        end
    end,
})

-- Configure diagnostic settings
vim.diagnostic.config({

    -- Define LSP diagnostic signs
    -- local icons = require("configs.icons");
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "󰌶",
            [vim.diagnostic.severity.HINT] = "󰌶",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Warn",
            [vim.diagnostic.severity.INFO] = "Info",
            [vim.diagnostic.severity.HINT] = "Hint",
        },
    },

    -- virtual_text = { current_line = true }
    virtual_lines = { current_line = true },
})

-- This is copied straight from blink
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
    },
}

--capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Setup language servers.

vim.lsp.config("*", {
    --   capabilities = capabilities,
    root_markers = { ".git" },
})

local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "jdtls", "pyright", "ruff" }

-- Enable each language server by filename under the lsp/ folder
vim.lsp.enable(servers)
