return {
  {
    "rmagatti/auto-session",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/", "/" },
      })

      vim.keymap.set("n", "<leader>wr", "<der>fmcmd>SessionRestore<cr>", { desc = "Restore session for cwd" })
      vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "Save session" })
    end,
    init = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },
}
