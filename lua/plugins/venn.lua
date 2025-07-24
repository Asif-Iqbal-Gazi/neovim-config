local toggle_venn -- forward declaration

local M = {
    "jbyuki/venn.nvim",

    keys = {
        {
            "<leader>tv",
            function() toggle_venn() end,
            desc = "Toggle Venn Diagram Mode",
        },
    },

    config = function()
        toggle_venn = function()
            local venn_enabled = vim.inspect(vim.b.venn_enabled)
            if venn_enabled == "nil" then
                vim.b.venn_enabled = true
                vim.cmd [[setlocal ve=all]]
                local opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", opts)
                vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", opts)
                vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", opts)
                vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", opts)
                vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", opts)
                vim.notify("Venn: Drawing mode enabled")
            else
                vim.cmd [[setlocal ve=]]
                vim.api.nvim_buf_del_keymap(0, "n", "J")
                vim.api.nvim_buf_del_keymap(0, "n", "K")
                vim.api.nvim_buf_del_keymap(0, "n", "L")
                vim.api.nvim_buf_del_keymap(0, "n", "H")
                vim.api.nvim_buf_del_keymap(0, "v", "f")
                vim.b.venn_enabled = nil
                vim.notify("Venn: Drawing mode disabled")
            end
        end
    end,
}

return M
