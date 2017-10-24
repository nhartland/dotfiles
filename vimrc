set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" syntax highlights
syntax enable
colorscheme jellybeans 

" tabs
set tabstop=4
set softtabstop=4
set expandtab

" Spelling
autocmd FileType gitcommit  setlocal spell spelllang=en_gb
autocmd FileType markdown   setlocal spell spelllang=en_gb
autocmd FileType tex        setlocal spell spelllang=en_gb

" UI
set number
"set relativenumber
set showcmd
set cursorline
set wildmenu
set wildmode=full
set lazyredraw
set showmatch
set ruler

" Search
set incsearch
"set hlsearch

" General
set esckeys
set autowrite
set autoindent
set autoread
set showcmd
filetype plugin indent on

" move by vertical line
nnoremap j gj
nnoremap k gk

" lightline
set laststatus=2

" ale
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
