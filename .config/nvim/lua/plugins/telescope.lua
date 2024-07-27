return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({
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

    local builtin = require("telescope.builtin")
    vim.keymap.set('n', "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find string in cwd" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Lists open buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Lists available help tags" })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Lists previously open files" })
    vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, { desc = "List buffer's git commits" })
    vim.keymap.set('n', '<leader>gC', builtin.git_commits, { desc = "List git commits" })
  end
}
