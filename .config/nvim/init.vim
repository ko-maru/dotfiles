" load vim config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" general
syntax on
filetype plugin indent on

" file
set autoread
set encoding=utf-8
set nobackup
set hidden

"
" edit
"
set backspace=indent,eol,start

"
" indentation
"
set autoindent
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2

"
" view
"
set background=dark
set cursorline
set laststatus=2
set linebreak
set list
set listchars=tab:>-,trail:-,nbsp:+
set number
set relativenumber
set ruler
set showcmd
set showmatch
set noshowmode
set updatetime=100
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
" terminal integration
"
set clipboard^=unnamedplus
set mouse=a
if (has("termguicolors"))
  set termguicolors
endif


" leader
let mapleader = "\<Space>"
let maplocalleader = "<Bslash>"

inoremap jk <Esc>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap Q gq
nnoremap gQ Q

nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>

nnoremap <leader><space> :noh<cr>

" auto reload vimrc
augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim source <afile>
augroup END

if has('nvim')
  lua require('plugins')
endif
