local M = {
    "numToStr/Comment.nvim",
    keys = {
        { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment", mode = "n" },
        { "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  desc = "Comment", mode = "v" },
    },
}

return M
