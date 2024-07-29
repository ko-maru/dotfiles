vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc
]])

vim.env.PATH = vim.env.HOME .. "./local/share/mise/shims:" .. vim.env.PATH

require("config.fix-cellwidth")

require("config.lazy")
