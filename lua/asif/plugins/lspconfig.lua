local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "saghen/blink.cmp", "folke/neodev.nvim" },
}

-- Function to set keymaps for LSP features
local function set_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymaps = {
    gd = "<cmd>lua vim.lsp.buf.definition()<CR>",   -- Go to definition
    gD = "<cmd>lua vim.lsp.buf.declaration()<CR>",  -- Go to declaration
    K = "<cmd>lua vim.lsp.buf.hover()<CR>",         -- Show documentation
    gI = "<cmd>lua vim.lsp.buf.implementation()<CR>", -- Go to implementation
    gr = "<cmd>lua vim.lsp.buf.references()<CR>",   -- Find references
    gl = "<cmd>lua vim.diagnostic.open_float()<CR>", -- Show diagnostics
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
  if client.supports_method("textDocument/semanticTokens") then
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
  local wk = require("which-key")
  local lspconfig = require("lspconfig")
  local icons = require("asif.configs.icons")

  -- Register key mappings with descriptions for LSP commands
  local wk_mappings = {
    { "<leader>l",  group = "LSP" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
    { "<leader>li", "<cmd>LspInfo<cr>",                        desc = "LSP Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    {
      "<leader>lh",
      "<cmd>lua require('asif.plugins.lspconfig').toggle_inlay_hints()<cr>",
      desc = "Toggle Inlay Hints",
    },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>",  desc = "Previous Diagnostic" },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",      desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostics Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",        desc = "Rename Symbol" },
  }
  wk.add(wk_mappings)

  -- Configure diagnostic settings
  vim.diagnostic.config({
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
  })

  -- Define LSP diagnostic signs
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- Define handlers for hover and signature help popups
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  }
  for method, handler in pairs(handlers) do
    vim.lsp.handlers[method] = handler
  end

  -- Set default border style for LSP UI windows
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- Define the list of LSP servers to be installed
  local servers = { "html", "clangd", "lua_ls", "jsonls", "ts_ls", "jdtls" }

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
