local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { { "folke/neodev.nvim" } },
}

local on_attach_keymaps = {
  gd = "<cmd>lua vim.lsp.buf.definition()<CR>",
  gD = "<cmd>lua vim.lsp.buf.declaration()<CR>",
  K = "<cmd>lua vim.lsp.buf.hover()<CR>",
  gI = "<cmd>lua vim.lsp.buf.implementation()<CR>",
  gr = "<cmd>lua vim.lsp.buf.references()<CR>",
  gl = "<cmd>lua vim.diagnostic.open_float()<CR>",
}

M.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  for key, cmd in pairs(on_attach_keymaps) do
    vim.api.nvim_buf_set_keymap(bufnr, "n", key, cmd, opts)
  end

  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Newly Added
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false, bufnr = bufnr })
      end,
    })
  end
end

M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.offsetEncoding = { "utf-16" }
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

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
end

function M.config()
  local wk = require("which-key")
  local lspconfig = require("lspconfig")
  local icons = require("asif.configs.icons")
  local wk_mappings = {
    { "<leader>l",  group = "LSP" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
    { "<leader>li", "<cmd>LspInfo<cr>",                                                    desc = "LSP Info" },
    {
      "<leader>lj",
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      desc = "Next Diagnostic",
    },
    { "<leader>lh", "<cmd>lua require('asif.plugins.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
    {
      "<leader>lk",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      desc = "Prev Diagnostic",
    },
    {
      "<leader>ll",
      "<cmd>lua vim.lsp.codelens.run()<cr>",
      desc = "CodeLens Action",
    },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",        desc = "Rename" },
  }
  wk.add(wk_mappings)

  -- Diagnostic Configuration (Refactored)
  local diagnostic_config = {
    signs = true,
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
  vim.diagnostic.config(diagnostic_config)

  -- Define signs
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- Handlers (Simplified)
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  }
  for method, handler in pairs(handlers) do
    vim.lsp.handlers[method] = handler
  end

  require("lspconfig.ui.windows").default_options.border = "rounded"

  local servers = {
    "html",
    "clangd",
    "lua_ls",
    "jsonls",
    "ts_ls",
  }

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.capabilities,
      on_init = M.on_init,
    }

    local require_ok, settings = pcall(require, "asif.config.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("neodev").setup({})
    end

    lspconfig[server].setup(opts)
  end
end

return M
