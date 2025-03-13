local M = {
  "saghen/blink.cmp",
  version = "v0.13.1",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
}

function M.config()
  local blink = require("blink.cmp")

  blink.setup({
    -- Use a release tag to download pre-built binaries
    -- OR build from source, requires nightly Rust
    -- build = 'cargo build --release',
    -- build = 'nix run .#build-plugin',

    keymap = {
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },

      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<C-n>"] = { "show_signature", "hide_signature", "fallback" },

    },
    cmdline = {
      keymap = {
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.select_next()
            else
              return cmp.show()
            end
          end,
          "select_next",
          "fallback",
        },
      },
    },

    signature = { enabled = true },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        auto_show = true,
        border = "rounded",
        --        scrolloff = 1,
        scrollbar = false,
        -- draw = {
        --   treesitter = { 'lsp' },
        -- }
      },
      documentation = {
        auto_show_delay_ms = 0,
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
  })
end

return M
