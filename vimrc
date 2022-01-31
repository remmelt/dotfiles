set nocompatible
filetype off

" turn off automatic mouse support in visual mode
set mouse-=a

" Show line numbers
set number

" https://github.com/ntpeters/vim-better-whitespace
" autocmd BufWritePre * StripWhitespace

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Use rg instead of grep, also for ctrlP
if executable('rg')
  set grepprg=rg
endif

" Indentation
filetype plugin indent on
set autoindent
set cindent
set smartindent
set copyindent

" Full support for Backspace in Insert mode
set backspace=2

" Syntax highlighting ftw!
syntax on

" Status bar
set ls=2

" Start scrolling 12 lines before edge of viewport
set scrolloff=12

" Search stuff
" Case insensitive search
set ignorecase
" Case sensitive if including capitals.
set smartcase
" Highlight search matches
set hlsearch
" Incremental search
set incsearch

" Set the map leader to ' ' (space)
" Note that space is also set to remove highlighted searches, so that will
" happen only after a timeout (defaults to 1s)
let mapleader = "\<Space>"

" Press ENTER in normal mode to save the current file.
nnoremap <Enter> :w<CR>

" No backups
set nobackup
set nowritebackup
set noswapfile

" Toggle paste mode with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Tabs instead of spaces for Go.
" au FileType go setlocal tabstop=4 noexpandtab shiftwidth=4 softtabstop=4

" Hide scrollbars
if has("gui_running")
  set go-=rL
endif

" Automatically reload on file change
set autoread

" Highlight current line
:set cursorline

" Use system clipboard
"set clipboard=unnamed

