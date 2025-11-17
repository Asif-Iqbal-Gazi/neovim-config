-- ============================================
-- LSP and Diagnostic Configuration for Neovim
-- ============================================

-- Utility function to toggle diagnostic display modes:
-- Cycles through: virtual_lines (current line only) → virtual_text (current line only) → disabled
local function toggle_diagnostics_mode()
    local config = vim.diagnostic.config()
    local vlines = config.virtual_lines or {}
    local vtext = config.virtual_text or {}

    local is_lines_current = type(vlines) == "table" and vlines.current_line == true
    local is_text_current = type(vtext) == "table" and vtext.current_line == true

    if is_lines_current then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = { current_line = true, source = "if_many" },
        })
        vim.notify("Diagnostics: Virtual Text (Current Line)")
    elseif is_text_current then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = false,
        })
        vim.notify("Diagnostics: Disabled")
    else
        vim.diagnostic.config({
            virtual_lines = { current_line = true },
            virtual_text = false,
        })
        vim.notify("Diagnostics: Virtual Lines (Current Line)")
    end
end

-- ==================================================
-- LSP Keymaps & Feature Setup (Triggered on Attach)
-- ==================================================
-- Enable features and keymaps only when an LSP attaches to a buffer
-- See :help LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
    callback = function(event)
        local bufnr = vim.api.nvim_get_current_buf()
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Keymap utility
        local function map(keys, cmd, desc, mode)
            vim.keymap.set(mode or "n", keys, cmd, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        -- Code Navigation
        map("grd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
        map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("grt", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")
        map("gri", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
        map("grD", require("fzf-lua").lsp_declarations, "[G]oto [D]eclaration")

        -- Symbols
        map("gO", require("fzf-lua").lsp_document_symbols, "[G]oto Document Symbols")
        map("gW", require("fzf-lua").lsp_live_workspace_symbols, "[G]oto [W]orkspace Symbols")

        -- Diagnostics
        map("gdD", require("fzf-lua").diagnostics_document, "[G]oto [D]iagnostics [D]ocument")
        map("gdW", require("fzf-lua").diagnostics_workspace, "[G]oto [D]iagnostics [W]orkspace")
        map("gdq", vim.diagnostic.setloclist, "[G]oto [D]iagnostic [Q]uickFix")
        map("gdl", vim.diagnostic.open_float, "[G]oto [D]iagnostic Current [L]ine")

        -- Code Actions
        map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("grn", vim.lsp.buf.rename, "Rename Symbol")

        -- Hover & Signature Help
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-S>", vim.lsp.buf.signature_help, "Signature Help", { "i", "s" })

        -- Toggle inlay hints (if supported)
        if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
            end, "Toggle Inlay Hints")
        end

        -- Toggle diagnostics visual mode
        map("<leader>td", toggle_diagnostics_mode, "Toggle Diagnostic Display")

        ------------------------------------------------------------------------
        -- Highlight word under cursor (see :help CursorHold)
        ------------------------------------------------------------------------
        if client and client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_group,
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
    end,
})

-- ==============================
-- Global Diagnostic Preferences
-- ==============================
-- Configure diagnostic settings
-- See `:help vim.diagnostic.Opts`
vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    -- virtual_text = { current_line = true, source = "if_many" },
    virtual_lines = { current_line = true },
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
})

-- =========================================
-- Default LSP Capabilities and Server Setup
-- =========================================
vim.lsp.config("*", {
    capabilities = require("blink-cmp").get_lsp_capabilities(),
    root_markers = { ".git" },
})

-- List of language servers to enable
local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "jdtls", "prettierd", "ruff", "rust_analyzer", "shfmt" }
vim.lsp.enable(servers)
