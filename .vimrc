"---------------------------
" File format
"---------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp,default,latin
set fileformats=unix,dos,mac
filetype on
syntax on

"---------------------------
" Menu
"---------------------------
set langmenu=none
set wildmenu
set wildmode=list:longest

"---------------------------
" View
"---------------------------
set number
set relativenumber
set cursorline
set showmatch
set laststatus=2
set nowrap
set ambiwidth=double
set showmatch
set display=lastline
set list
set listchars=tab:^\ ,trail:~
set virtualedit=onemore

if has('termguicolors')
  set termguicolors
endif

if has("nvim")
  set laststatus=3
endif

"---------------------------
" Edit
"---------------------------
set tabstop=2
set softtabstop=-1
set shiftwidth=0
set autoindent
set smartindent
set smarttab
set expandtab
set mouse=a
set hidden
set clipboard& clipboard+=unnamedplus
set nomodeline

if has('wsl')
  let g:clipboard = {
    \   'name': 'wsl-clipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }
endif

"---------------------------
" Search
"---------------------------
set incsearch
set ignorecase
set smartcase
set wrapscan
set hlsearch
set history=1000

"---------------------------
" Keymaps
"---------------------------
let mapleader = "\<space>"

" Move
noremap j gj
noremap k gk

" Indent
vnoremap > >gv
vnoremap < <gv

" Move buffer
nnoremap <silent> L :bnext<cr>
nnoremap <silent> H :bprev<cr>

" Window
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l

" Yank
vnoremap v <esc>V
nnoremap x "_x
nnoremap s "_s

" Clear highlight
nnoremap <silent> <esc><esc> <cmd>nohlsearch\|diffupdate\|normal! <c-l><cr>

" Open setting
nnoremap <leader>, :e $MYVIMRC<cr>

"---------------------------
" Autocommands
"---------------------------
augroup vimrc
  autocmd!
  autocmd BufWritePost ~/.vimrc source $MYVIMRC
augroup END

" Makefile
augroup makefile
  autocmd! FileType make setlocal tabstop=4 noexpandtab
augroup END
