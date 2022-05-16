set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/mappings.vim

lua require('plugins')
