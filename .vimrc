" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Sets syntax + indentation per filetype
syntax on
filetype on
filetype plugin on
filetype indent on

" Tab stuff
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set nocompatible
set cursorline " Adds horizontal line through cursor
set showmatch

" Code folds at indent
set foldenable
set foldlevelstart=10
set foldmethod=indent

" Enable mouse
set mouse=a

set shell=sh
set title
set number
set ruler
set hidden " Can change buffer without saving current
set history=1000

set ignorecase
set smartcase
set hlsearch
set incsearch

" Show whitespace
set listchars=tab:>-,trail:·,eol:$
nnoremap <silent> <leader>s :set nolist!<CR>

" remap to beginning/end of line
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

nnoremap <tab> %
vnoremap <tab> %

nnoremap j gj
nnoremap k gk

" Remap leader
let mapleader = "\<Space>"

" Easy C+P
vmap <leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Fix sloppy linux
set backspace=indent,eol,start

" CtrlP stuff
" Ignore everything in .gitignore:
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']  

" NERDTree Stuff
map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Stuff
map <C-_> <leader>c<space>

call plug#begin()    
" Theme
Plug 'altercation/vim-colors-solarized'
" Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
" vimrc defaults
Plug 'tpope/vim-sensible'
" Tree view
Plug 'scrooloose/nerdtree'
" Async Linters
Plug 'neomake/neomake'
" Modify brackets, tags, quotes, etc easily
Plug 'tpope/vim-surround'
" Nice bar @ bottom
Plug 'bling/vim-airline'
" Easy commenting
Plug 'scrooloose/nerdcommenter'
" Notes git diffs in gutter
Plug 'airblade/vim-gitgutter'
" Shows git status in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Auto-brackets
Plug 'Raimondi/delimitMate'

" FILETYPE STUFF
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'

call plug#end()

" Enable solarized theme
syntax enable
set background=dark
colorscheme solarized
