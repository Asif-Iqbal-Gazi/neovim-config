local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      lazy = true,
    },
  },
}

local wk_mappings = {
  { "<leader>f",  group = "Find" },
  { "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>",   desc = "Find buffers" },
  { "<leader>fc", "<cmd>Telescope git_commits<cr>",               desc = "Git Commits" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find files" },
  -- { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
  { "<leader>ft", "<cmd>Telescope live_grep<cr>",                 desc = "Find text" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help" },
  { "<leader>fl", "<cmd>Telescope resume<cr>",                    desc = "Last Search" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Find Recent File" },
  { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },
}

function M.config()
  local wk = require("which-key")
  wk.add(wk_mappings)

  local icons = require("asif.configs.icons")
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = { theme = "dropdown" },
      grep_string = { theme = "dropdown" },
      find_files = { theme = "dropdown", previewer = false },
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = { ["<C-d>"] = actions.delete_buffer },
          n = { ["dd"] = actions.delete_buffer },
        },
      },
      planets = { show_pluto = true, show_moon = true },
      colorscheme = { enable_preview = true },
      lsp_references = { theme = "dropdown", initial_mode = "normal" },
      lsp_definitions = { theme = "dropdown", initial_mode = "normal" },
      lsp_declarations = { theme = "dropdown", initial_mode = "normal" },
      lsp_implementations = { theme = "dropdown", initial_mode = "normal" },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })
end

return M
