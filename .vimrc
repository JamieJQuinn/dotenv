" Remap leader
let mapleader = "\<Space>"

" Fix sloppy linux
set backspace=indent,eol,start

" Tab stuff
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Sets syntax + indentation per filetype
syntax on
filetype on
filetype plugin on
filetype indent on

" Code folds at indent
set foldenable
set foldlevelstart=10
set foldmethod=indent
" Mouse support
set mouse=a
" Shell
set shell=sh
" Vim replaces term title with files being edited
set title
"Line numbering
"set number
"set relativenumber
" Current number tracking
set ruler
" Can change buffer without saving current
set hidden 
" Increase history limit
set history=1000
" Who needs vi?
set nocompatible
" Adds horizontal line through cursor
set cursorline 
" Show matching brackets
set showmatch

" Search options
set ignorecase
set smartcase
set hlsearch
set incsearch

" Set global swapfile storage, rather than clutter working dirs
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Show whitespace
set listchars=tab:>-,trail:·,eol:$
nnoremap <silent> <Leader>s :set nolist!<CR>

" Remap to beginning/end of line
noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

" Easier bracket matching
nnoremap <tab> %
vnoremap <tab> %

" Better movement
nnoremap j gj
nnoremap k gk

" Easy C+P
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

function! ToggleGutter()
  :set invnumber
  :set invrelativenumber
endfunction

nnoremap <Leader>g :GitGutterSignsToggle<CR>
nnoremap <Leader>n :call ToggleGutter()<CR>

nnoremap <Leader>v :vspl<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

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

" CtrlP stuff
" Ignore everything in .gitignore:
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" NERDTree Stuff
map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Stuff
map <C-_> <Leader>c<space>

" Enable solarized theme
syntax enable
set background=dark
colorscheme solarized
