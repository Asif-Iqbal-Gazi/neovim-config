local M = {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        --keymap = { preset = "default" },
        keymap = {
            preset = 'enter'
            -- ["<Up>"] = { "select_prev", "fallback" },
            -- ["<Down>"] = { "select_next", "fallback" },
            -- ["<C-k>"] = { "select_prev", "fallback" },
            -- ["<C-j>"] = { "select_next", "fallback" },
            --
            -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            --
            -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            -- ["<C-e>"] = { "hide", "fallback" },
            --
            -- ["<CR>"] = { "accept", "fallback" },
            --
            -- ["<Tab>"] = {
            --     function(cmp)
            --         if cmp.snippet_active() then
            --             return cmp.accept()
            --         else
            --             return cmp.select_and_accept()
            --         end
            --     end,
            --     "snippet_forward",
            --     "fallback",
            -- },
            -- ["<S-Tab>"] = { "snippet_backward", "fallback" },
            --
            -- ["<C-n>"] = { "show_signature", "hide_signature", "fallback" },
        },
        cmdline = {
            keymap = {
                preset = 'cmdline',
                ["<CR>"] = { "accept", "fallback" },
                -- ["<Up>"] = { "select_prev", "fallback" },
                -- ["<Down>"] = { "select_next", "fallback" },
                -- ["<C-k>"] = { "select_prev", "fallback" },
                -- ["<C-j>"] = { "select_next", "fallback" },
                --
                -- ["<CR>"] = { "accept", "fallback" },
                --
                -- ["<Tab>"] = {
                --     function(cmp)
                --         if cmp.snippet_active() then
                --             return cmp.select_next()
                --         else
                --             return cmp.show()
                --         end
                --     end,
                --     "select_next",
                --     "fallback",
                -- },
            },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- Enable signature
        signature = {
            enabled = true,
            window = {
                border = "rounded",
                scrollbar = false,
            },
        },

        -- (Default) Only show the documentation popup when manually triggered
        -- completion = { documentation = { auto_show = false } },
        completion = {
            -- 'prefix' will fuzzy match on the text before the cursor
            -- 'full' will fuzzy match on the text before _and_ after the cursor
            -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
            keyword = { range = "full" },

            -- Disable auto brackets
            -- NOTE: some LSPs may add auto brackets themselves anyway
            accept = { auto_brackets = { enabled = true } },

            -- Don't select by default, auto insert on selection
            list = { selection = { preselect = false, auto_insert = false } },
            -- or set via a function
            -- list = { selection = { preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end } },

            menu = {
                -- automatically show the completion menu
                auto_show = true,
                border = "rounded",
                scrollbar = false,
                -- nvim-cmp style menu
                draw = {
                    columns = {
                        { "label",     "label_description", gap = 1 },
                        { "kind_icon", "kind" },
                    },
                },
            },

            -- Show documentation when selecting a completion item
            documentation = { auto_show = true, auto_show_delay_ms = 5, window = { border = "rounded" } },

            -- Display a preview of the selected item on the current line
            ghost_text = { enabled = true },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}

return M
