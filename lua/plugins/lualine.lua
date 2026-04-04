local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "catppuccin-nvim",
            ignore_focus = { "NvimTree" },
            globalstatus = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff" },
            lualine_c = {
                { "filename", path = 1 },       -- relative path
                {
                    -- macro recording indicator
                    function()
                        local reg = vim.fn.reg_recording()
                        if reg ~= "" then return "󰑊 @" .. reg end
                        return ""
                    end,
                    color = { fg = "#f38ba8" },  -- red when recording
                },
            },
            lualine_x = {
                {
                    "diagnostics",
                    sources = { "nvim_lsp" },
                    symbols = { error = " ", warn = " ", info = "󰌶 ", hint = "󰌶 " },
                },
                {
                    -- active LSP server name
                    function()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if #clients == 0 then return "" end
                        local names = vim.tbl_map(function(c) return c.name end, clients)
                        return " " .. table.concat(names, ", ")
                    end,
                },
                "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = { "quickfix", "man", "oil", "fzf", "lazy", "fugitive" },
    },
}

return M
