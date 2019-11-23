set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'slim-template/vim-slim.git'
Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'elzr/vim-json'
Plugin 'Shougo/deoplete.nvim'
Plugin 'ntpeters/vim-better-whitespace'

call vundle#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Use smartcase.
let g:deoplete#enable_smart_case = 1

" Set lightline theme
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"\ue0a2":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

" Colorscheme
set background=dark
colorscheme solarized

" turn off automatic mouse support in visual mode
set mouse-=a

" NerdTree
map <silent> <C-n> :NERDTreeTabsToggle<CR>
:let NERDTreeQuitOnOpen = 0

" Automatically write file to disk when calling :make
set autowrite

" Show line numbers
set number

" Lightline already shows mode
set noshowmode

" https://github.com/ntpeters/vim-better-whitespace
autocmd BufWritePre * StripWhitespace

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

" Trigger CommandP
map <C-p> :CtrlP<CR>
" Open files in tab by default https://github.com/kien/ctrlp.vim/issues/160
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<c-t>'],
\ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
\ }

" Toggle paste mode with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Tabs instead of spaces for Go.
au FileType go setlocal tabstop=4 noexpandtab shiftwidth=4 softtabstop=4

" Hide scrollbars
if has("gui_running")
  set go-=rL
endif

" Automatically reload on file change
set autoread

" This allows you to visually select a section and then hit @ to run a macro
" on all lines. Only lines which match will change. Without this script the
" macro would stop at lines which don’t match the macro.
" https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Some custom file extensions
" Salt State files:
au BufReadPost *.sls set syntax=yaml

" https://github.com/fatih/vim-go
" :GoInstallBinaries
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" https://github.com/elzr/vim-json
let g:vim_json_syntax_conceal = 0

" Highlight current line
:set cursorline

" http://superuser.com/questions/410982/in-vim-how-can-i-quickly-switch-between-tabs
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" Use system clipboard
set clipboard=unnamed

