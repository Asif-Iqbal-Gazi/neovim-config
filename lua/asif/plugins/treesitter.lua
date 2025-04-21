local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdate" },
    build = ":TSUpdate",
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "lua",
            "vim",
            "vimdoc",
            "html",
            "css",
            "bash",
            "json",
            "java",
            "javascript",
            "python",
            "markdown",
            "markdown_inline",

        },
        sync_install = false,
        -- Autoinstall languages that are not installed
        auto_install = true,
        ignore_install = {},
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                scope_incremental = "<CR>",
                node_incremental = "<TAB>",
                node_decremental = "<S-TAB>",
            },
        },
    }
}

return M
