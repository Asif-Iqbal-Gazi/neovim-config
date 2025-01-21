local M = {
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPre" },
}

function M.config()
  require("colorizer").setup({
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
  })
end

return M
