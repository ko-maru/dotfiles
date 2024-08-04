return {
  {
    "rmagatti/auto-session",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>ws", "<cmd>SessionSave<cr>", desc = "Save session" },
      { "<leader>wr", "<cmd>SessionRestore<cr>", desc = "Restore session for cwd" },
      { "<leader>fw", "<cmd>SessionSearch<cr>", desc = "Session search" },
    },
    config = function()
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/", "/" },
      })
    end,
    init = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },
}
