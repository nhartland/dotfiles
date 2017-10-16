execute pathogen#infect()

" syntax highlights
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" tabs
set tabstop=4
set softtabstop=4
set expandtab

" UI
set number
"set relativenumber
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set ruler

" Search
set incsearch
"set hlsearch

" General
set autoindent
set autoread
filetype plugin indent on

" move by vertical line
nnoremap j gj
nnoremap k gk

" lightline
set laststatus=2

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
