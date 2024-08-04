return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "folke/trouble.nvim",
  },
  cmd = { "Telescope" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files in cwd" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find string in cwd" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Lists open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Lists available help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Lists previously open files" },
    { "<leader>gc", "<cmd>Telescope git_bcommits<cr>", desc = "List buffer's git commits" },
    { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "List git commits" },
  },
  config = function()
    local open_with_trouble = require("trouble.sources.telescope").open

    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { ".git/" },
        mappings = {
          n = { ["<c-t>"] = open_with_trouble },
          i = { ["<c-t>"] = open_with_trouble },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extension = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    require("telescope").load_extension("fzf")
  end,
}
