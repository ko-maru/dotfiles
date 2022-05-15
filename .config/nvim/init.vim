set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc
set nocompatible

" file
set autoread
set encoding=utf-8
set nobackup
set hidden"

"
" syntax highlighting
"
syntax on
filetype plugin indent on

"
" edit
"
set backspace=indent,eol,start

"
" terminal
"
set clipboard^=unnamedplus
set mouse=a

"
" indentation
"
set autoindent
set expandtab
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2

"
" view
"
set ambiwidth=double
set background=dark
set cursorline
set laststatus=2
set linebreak
set number
set relativenumber
set ruler
set showcmd
set showmatch
set noshowmode
set virtualedit=onemore
set visualbell
set wildmenu
set wildmode=list:longest
set wrap

"
" search
"
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

"
" history
"
set history=1000

"
" Key maps
"
let mapleader = " "
inoremap jk <ESC>

noremap j gj
noremap k gk

nnoremap <leader><space> :noh<cr>

"
" plugins
"
source ~/.config/nvim/plugin.vim
