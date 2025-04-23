local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
}

function M.config()
    local null_ls = require("null-ls")

    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local hover = null_ls.builtins.hover
    local completion = null_ls.builtins.completion

    null_ls.setup({
        debug = false,
        sources = {
            formatting.stylua,
            require("none-ls.formatting.ruff").with({
                extra_args = { "--extend-select", "I" },
            }),
            require("none-ls.formatting.ruff_format"),
            -- formatting.prettier,
            -- formatting.black,
            formatting.prettier.with({
                filetypes = { "json", "yaml", "markdown" },
            }),
            -- formatting.prettier.with {
            --   extra_filetypes = { "toml" },
            --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            -- },
            formatting.shfmt.with({
                args = { "-i", "4" },
            }),
            -- formatting.eslint,
            -- null_ls.builtins.diagnostics.flake8,
            -- diagnostics.flake8,
            completion.spell,
        },
    })
end

return M
