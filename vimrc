set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" syntax highlights
syntax enable
"colorscheme blaquemagick
colorscheme jellybeans 

" tabs
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Personal wiki
let g:wiki = { 'root' : '~/wiki' }

" Spelling
" Regenerate spl file if needed
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

" Writing mode
function! Writing()
  setlocal spell spelllang=en_gb 
  setlocal wrap linebreak
  setlocal softtabstop=4 tabstop=4 shiftwidth=4
  setlocal textwidth=80 wrapmargin=2
  " Don't count acronyms/ abbreviations as spelling errors.
  syntax match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
  " Don't count url-ish things as spelling errors
  syntax match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
  " highlight double words ("word word")
  syn match doubleWord "\c\<\(\a\+\)\_s\+\1\>"
  hi def link doubleWord Error
endfunction
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown " Identify .md as markdown
autocmd FileType gitcommit  call Writing() 
autocmd FileType markdown   call Writing()
autocmd FileType wiki       call Writing()
autocmd FileType tex        call Writing()

" UI
set number
"set relativenumber
set showcmd
set cursorline
set path+=** " Recursive find searched subdirectories
set wildmenu
set wildmode=list:longest,full
set lazyredraw
set showmatch
set ruler

" Search
set incsearch
"set hlsearch
set ignorecase
set smartcase " Search is case sensitive only when a capital letter is present in the search string

" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" General
set esckeys
set autowrite
set autoindent " not sure about this one
set autoread
set showcmd
filetype plugin indent on
set undolevels=1000 " max number of undo levels
set visualbell

" Split buffers open to right and below
set splitbelow
set splitright

" move by vertical line
nnoremap j gj
nnoremap k gk

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" lightline
set laststatus=2

" ale
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
