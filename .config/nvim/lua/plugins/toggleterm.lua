return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({})

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
    function _lazygit_toggle()
      lazygit:toggle()
    end

    local lazydocker = Terminal:new({ cmd = "lazydocker", direction = "float", hidden = true })
    function _lazydocker_toggle()
      lazydocker:toggle()
    end

    vim.keymap.set("n", "<leader>gl", "<cmd>lua _lazygit_toggle()<cr>", { silent = true })
    vim.keymap.set("n", "<leader>dl", "<cmd>lua _lazydocker_toggle()<cr>", { silent = true })
  end,
}
