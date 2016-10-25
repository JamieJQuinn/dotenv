" Remap leader
let mapleader = "\<Space>"

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
Plug 'vim-airline/vim-airline-themes'
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
" Code Completion
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" Searching
Plug 'rking/ag.vim', {'on': 'Ag'}
" Testing in vim
Plug 'janko-m/vim-test'

" FILETYPE STUFF
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'parkr/vim-jekyll'
Plug 'jalvesaq/Nvim-R'
Plug 'tpope/vim-markdown'
" Python indentation
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'

call plug#end()

" CtrlP stuff
" Ignore everything in .gitignore:
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Fugitive
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gd :Gdiff<CR>

" Vim-Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.mkd set filetype=markdown
autocmd BufNewFile,BufReadPost *.mdk set filetype=markdown

" NERDTree Stuff
map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Stuff
map <C-_> <Leader>c<space>

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

if executable('pt')
  " Tell unite to use ag for searching
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
  " Tell ag.vim to use pt binary
  let g:ag_prg="pt --nogroup --nocolor --column"
  let g:ag_working_path_mode="r"
endif

" Vim Test
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>

function! EchoStrategy(cmd)
  echo 'Command for running tests: ' . a:cmd
endfunction
let test#custom_strategies = {'echo': function('EchoStrategy')}
"let test#strategy = 'echo'
let test#elixir#exunit#executable = 'elixir --erl "-smp enable" -S mix test'
let test#filename_modifier = ':p'
let test#strategy = "neovim"

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols (Incase of lack of font)
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Enable solarized theme
syntax enable
set background=dark
colorscheme solarized

" Fix sloppy linux
set backspace=indent,eol,start

" Tab stuff
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Sets syntax + indentation per filetype
let python_highlight_all=1
syntax on
filetype plugin indent on

" Code folds at indent
set foldenable
set foldlevelstart=10
set foldmethod=indent
" Mouse support
set mouse=a
" Shell
set shell=/bin/sh
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

" Show whitespace
set listchars=tab:>-,trail:·,eol:$
nnoremap <silent> <Leader>w :set nolist!<CR>

" Enable/Disable spellchecker
noremap <silent> <Leader>s :set spelllang=en_gb invspell<CR>

" Remap to beginning/end of line
noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

" Easier bracket matching
nnoremap <tab> %
vnoremap <tab> %

" Better C+P
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Better movement
nnoremap j gj
nnoremap k gk

" Weaning myself off arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nmap <Leader>m :call ToggleMouse()<CR>

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
endfunc

function! ToggleGutter()
  :set invnumber
  :set invrelativenumber
endfunction

nnoremap <Leader>n :call ToggleGutter()<CR>

" Just easier commands
nnoremap <Leader>x :x<cr>
nnoremap <Leader>v :vspl<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>
