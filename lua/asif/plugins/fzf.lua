local M = {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    cmd = { "FzfLua" },
    opts = {},
    keys = {
        -- File Navigation
        { "<leader>ff", "<cmd>FzfLua files<cr>",         desc = "Find Files in Project" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",      desc = "Find Recently Opened Files" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>",       desc = "Find Open Buffers" },
        { "<leader>fz", "<cmd>FzfLua blines<cr>",        desc = "Find in Current Buffer" },

        -- Text Search
        { "<leader>ft", "<cmd>FzfLua live_grep<cr>",     desc = "Find Text in Project (Live Grep)" },
        { "<leader>fl", "<cmd>FzfLua resume<cr>",        desc = "Find Last Search Picker" },

        -- Git
        { "<leader>fc", "<cmd>FzfLua git_commits<cr>",   desc = "Find Git Commits" },

        -- Help & Docs
        { "<leader>fh", "<cmd>FzfLua helptags<cr>",      desc = "Find Help Tags" },
        { "<leader>fm", "<cmd>FzfLua manpages<cr>",      desc = "Find Man Pages" },

        -- Misc
        { "<leader>fs", "<cmd>FzfLua spell_suggest<cr>", desc = "Find Spelling Suggestions" },
        { "<leader>fs", "<cmd>FzfLua spell_suggest<cr>", desc = "Find Spelling Suggestions" },


        -- Optional: Project Picker (if Telescope extension enabled)
        -- { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Find Projects" },
    }
}

return M
