require("options")
require("keymaps")

-- bootstrap lazy.nvim
local repository_url = "https://github.com/folke/lazy.nvim.git"
local branch = "stable"
local lazy_path = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", repository_url, "--branch=" .. branch, lazy_path, })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
  },
})

vim.cmd.colorscheme "gruvbox"
