set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'slim-template/vim-slim.git'
Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive' 

call vundle#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Set lightline theme
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

" Show line numbers
set number

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Use ag instead of grep, also for ctrlP
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
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

" Start scrolling 9 lines before edge of viewport
set scrolloff=9

" Search stuff
" Case insensitive search
set ignorecase
" Case sensitive if including capitals.
set smartcase
" Highlight search matches
set hlsearch
" Incremental search
set incsearch

" Press Spacebar for cleaning highlighted search matches.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Press ENTER in navigation mode to save the current file.
nnoremap <Enter> :w<CR>

" No backups
set nobackup
set nowritebackup
set noswapfile

" Colorscheme
set background=dark
colorscheme solarized

" Trigger CommandP
map <C-p> :CtrlP<CR>

" Highlight whitespaces at the end of the lines
set listchars=tab:\|⋅,trail:⋅,nbsp:⋅
set list

" Remove trailing whitespaces
map S :%s/\s\+$//g<CR>:w<CR>

" Replace tabs with spaces
map tt :%s/\t/\ \ /g<CR>:w<CR>

" Remap ESC
inoremap jj <Esc>

" Tabs instead of spaces for Go.
au FileType go setl tabstop=2 noexpandtab shiftwidth=2 softtabstop=2

" Hide scrollbars
if has("gui_running")
  set go-=rL
endif

" Automatically reload on file change
set autoread

