set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gabesoft/vim-ags'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'scrooloose/nerdtree'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" General

set autoindent
set autoread
set encoding=utf-8
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2  " always show status line
set noswapfile
set number
set ruler
set scrolloff=3  " always have 3 lines showing above/below scroll pos
set shiftwidth=2
set showcmd  " extra info in the bottom bar when in visual mode
set showmatch
set smartcase  " only do case-sensitive search if there's a cap in the pattern
set tabstop=2
set softtabstop=2
set tabstop=8
set undofile  " remember undo history
set undodir=~/.vim/undofile/
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/     " MacOSX/Linux
set wildmenu  " fancy autocomplete for commands (try :color <tab> for demo)
set wildmode=longest,list,full

" Security
set modelines=0
set number
set visualbell
set encoding=utf-8

" Mouse/scroll
:set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" Paste from clipboard
set clipboard+=unnamed  " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Highlight extra (trailing) whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Color stuffs
if &term =~ '256color'
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Remap shortcuts
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" NerdTree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git$','\.hg','\.svn','\.bzr', '\.DS_Store']
let NERDTreeKeepTreeInNewTab=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Silver searcher

if executable('ag')
  let g:ackprg = 'ag --nogroup --column' " Use in Ack.vim

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use in CtrlP
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

  let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|node_modules\|public\/images\|public\/system\|data\|log\|tmp$',
	\ 'file': '\.exe$\|\.so$\|\.dat$'
	\ }

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" Syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=0

let syntastic_mode_map = { 'passive_filetypes': ['html', 'less'] }
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_javascript_checkers=['jshint']

" JSXHint, used for React JSX files
if executable('jsxhint')
  let g:syntastic_javascript_checkers=['jsxhint']
endif

" Virtualenvs
let g:virtualenv_auto_activate = 1

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL
