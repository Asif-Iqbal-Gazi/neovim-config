local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- the rewrite; master is frozen. Requires Nvim 0.12+
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSUninstall" }, -- main-branch commands
    build = ":TSUpdate",
}

-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
-- On the `main` branch there is no `setup{ highlight/indent/... }` table:
-- parsers are installed via install(), and highlighting/indent are enabled
-- per-buffer through a FileType autocommand.
local ensure_installed = {
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
}

function M.config()
    -- Install/update the parsers we care about (async, no-op if present).
    require("nvim-treesitter").install(ensure_installed)

    -- Enable treesitter highlighting + indentation for a buffer.
    local function ts_attach(buf)
        -- start() errors if no parser is available yet; ignore until installed.
        if pcall(vim.treesitter.start, buf) then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("my-treesitter", { clear = true }),
        callback = function(ev) ts_attach(ev.buf) end,
    })

    -- A buffer already open when this plugin lazy-loads won't fire a fresh
    -- FileType event, so attach to any loaded buffers now.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then ts_attach(buf) end
    end
end

return M
