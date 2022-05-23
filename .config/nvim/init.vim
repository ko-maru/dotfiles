set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

source $HOME/.config/nvim/options.vim
source $HOME/.config/nvim/mappings.vim

if has('nvim')
  lua require('plugins')
endif

" auto reload vimrc
augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim source <afile>
augroup END
