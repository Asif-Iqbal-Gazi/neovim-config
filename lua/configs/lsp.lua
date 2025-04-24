-- Enable features and keymaps only when an LSP attaches to a buffer
-- See :help LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
    callback = function(event)
        local bufnr = vim.api.nvim_get_current_buf()
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local function set_keymap(keys, cmd, desc)
            vim.keymap.set("n", keys, cmd, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        ------------------------------------------------------------------------
        -- Enable inlayHint if supported
        ------------------------------------------------------------------------
        if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        ------------------------------------------------------------------------
        -- Navigation (see :help lsp-method)
        ------------------------------------------------------------------------
        set_keymap("gd", "<cmd>FzfLua lsp_definitions<CR>", "Go to Definition")
        set_keymap("gD", "<cmd>FzfLua lsp_declarations<CR>", "Go to Declaration")
        set_keymap("gr", "<cmd>FzfLua lsp_references<CR>", "Go to References")
        set_keymap("gI", "<cmd>FzfLua lsp_implementations<CR>", "Go to Implementation")
        set_keymap("gtd", "<cmd>FzfLua lsp_typedefs<CR>", "Go to Type Definition")
        set_keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Hover Documentation")
        set_keymap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Line Diagnostics")

        ------------------------------------------------------------------------
        -- Code Actions & Formatting
        ------------------------------------------------------------------------
        set_keymap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")
        set_keymap("<leader>lf",
            "<cmd>lua vim.lsp.buf.format({ async = true, filter = function(client) return client.name ~= 'typescript-tools' end })<CR>",
            "Format Code")
        set_keymap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol")

        ------------------------------------------------------------------------
        -- LSP Info & Tools
        ------------------------------------------------------------------------
        set_keymap("<leader>li", "<cmd>LspInfo<CR>", "LSP Info")
        set_keymap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens")
        set_keymap("<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
        end, "Toggle Inlay Hints")

        ------------------------------------------------------------------------
        -- Diagnostics (see :help diagnostic)
        ------------------------------------------------------------------------
        set_keymap("<leader>ld", "<cmd>FzfLua diagnostics_document<CR>", "Document Diagnostics")
        set_keymap("<leader>lD", "<cmd>FzfLua diagnostics_workspace<CR>", "Workspace Diagnostics")
        set_keymap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic")
        set_keymap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic")
        set_keymap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Populate Loclist")

        ------------------------------------------------------------------------
        -- Symbols (Document/Workspace)
        ------------------------------------------------------------------------
        set_keymap("<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", "Document Symbols")
        set_keymap("<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", "Workspace Symbols")

        ------------------------------------------------------------------------
        -- Highlight word under cursor (see :help CursorHold)
        ------------------------------------------------------------------------
        -- if client and client.server_capabilities.documentHighlightProvider then
        --     local highlight_augroup = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })
        --
        --     vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --         buffer = event.buf,
        --         group = highlight_augroup,
        --         callback = vim.lsp.buf.document_highlight,
        --     })
        --
        --     vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        --         buffer = event.buf,
        --         group = highlight_augroup,
        --         callback = vim.lsp.buf.clear_references,
        --     })
        --
        --     vim.api.nvim_create_autocmd("LspDetach", {
        --         group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true }),
        --         callback = function(event2)
        --             vim.lsp.buf.clear_references()
        --             vim.api.nvim_clear_autocmds({ group = "my-lsp-highlight", buffer = event2.buf })
        --         end,
        --     })
        -- end
    end,
})


-- Configure diagnostic settings\
-- See `:help vim.diagnostic.config()`
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

    severity_sort = true,
    -- virtual_text = { current_line = true }
    virtual_lines = { current_line = true },
    float = {
        border = "rounded",
        header = "Diagnostic",
    }
})


-- Generic LSP configuration
vim.lsp.config("*", {
    capabilities = require("blink-cmp").get_lsp_capabilities(),
    root_markers = { ".git" },
})

-- Enable each language server by filename under the lsp/ folder
local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "jdtls", "pyright", "ruff" }
vim.lsp.enable(servers)
