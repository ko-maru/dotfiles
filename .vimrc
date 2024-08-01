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
set listchars=tab:>\ ,trail:-,nbsp:+
set virtualedit=onemore
set splitright
set splitbelow
set signcolumn=yes

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

" Increment and decrement
nnoremap + <c-a>
nnoremap - <c-x>

" lazygit / lazydocker
nnoremap <expr><silent> <leader>gl ':!tmux popup -w90\% -h90\% -d '.getcwd().' -E lazygit<cr><cr>'
nnoremap <expr><silent> <leader>cl ':!tmux popup -w90\% -h90\% -E lazydocker<cr><cr>'

"---------------------------
" Autocommands
"---------------------------
if has('wsl')
  autocmd! TextYankPost * :call system('iconv -t cp932 | clip.exe', @")
endif

augroup vimrc
  autocmd!
  autocmd BufWritePost ~/.vimrc source $MYVIMRC
augroup END

" Makefile
augroup makefile
  autocmd! FileType make setlocal tabstop=4 noexpandtab
augroup END

