local M = {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre" },
    opts = {
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "css",
            "html",
            "astro",
            "lua",
            "toml",
        },
        user_default_options = {
            names = false,
            rgb_fn = true,
            hsl_fn = true,
            tailwind = "both",
        },
        buftypes = {},

    }
}

return M
