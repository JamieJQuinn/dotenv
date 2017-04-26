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
Plug 'jiangmiao/auto-pairs'
" Searching
Plug 'rking/ag.vim', {'on': 'Ag'}
" Testing in vim
Plug 'janko-m/vim-test'
" Jekyll in vim
Plug 'parkr/vim-jekyll'
" Writing mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
Plug 'dbmrq/vim-ditto'
" Better repeat
Plug 'tpope/vim-repeat'
" More % matching
Plug 'vim-scripts/matchit.zip'
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" Better tab
Plug 'ervandew/supertab'
" Better Numbers
"Plug 'myusuf3/numbers.vim'

" FILETYPE STUFF
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'jalvesaq/Nvim-R'
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'suan/vim-instant-markdown'
Plug 'JamieJQuinn/vim-madoko'
Plug 'lervag/vimtex'
" Python indentation
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'

" Neovim only plugins
if has('nvim')
  " Code Completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/neocomplete.vim'
endif

call plug#end()

" markdown preview
let g:instant_markdown_autostart = 0
nnoremap <Leader>mp :InstantMarkdownPreview<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1

" neocomplete
let g:neocomplete#enable_at_startup = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Utilsnips
let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsEditSplit="vertical"

" CtrlP stuff
" Ignore everything in .gitignore:
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Fugitive
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>i
map <Leader>gd :Gdiff<CR>

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.mkd set filetype=markdown

" Latex
let g:tex_flavor='latex'

" NERDTree Stuff
map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Stuff
map <C-_> <Leader>c<space>

"Vim-R
let R_assign = 0

" Tabular
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_cpp_enabled_makers = []
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion', '-Wno-pragma-once-outside-header'],
   \ }

" Ag
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

" airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Limelight
let g:limelight_conceal_ctermfg = 241
let g:limelight_default_coefficient = 0.7

" Pencil
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
  autocmd FileType tex         call pencil#init()
augroup END
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0

" Writers mode
map <F10> :Goyo <bar> :Limelight!! <bar> :TogglePencil <CR>

" Ditto
au FileType markdown,text,tex DittoOn

" Enable solarized theme
syntax enable
set background=dark
colorscheme solarized

" Fix sloppy linux
set backspace=indent,eol,start

" Tab stuff
set tabstop=2 expandtab shiftwidth=2

" Sets syntax + indentation per filetype
let python_highlight_all=1
filetype plugin indent on

" Mouse support
set mouse=a
" Shell
set shell=/bin/bash
" Vim replaces term title with files being edited
set title
" Current number tracking
set ruler
" Can change buffer without saving current
set hidden
" Increase history limit
set history=1000
" Who needs vi?
set nocompatible
" Show matching brackets
set showmatch
" Search options
set ignorecase smartcase hlsearch incsearch
" disable folding
set nofoldenable
" Fix airline over ssh
set laststatus=2
" set column highlighting at character 80
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" Disable autocommenting
au FileType * set fo-=r fo-=o

" Show whitespace
set listchars=tab:>-,trail:· nolist!
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

" Call make
noremap <F6> :make<CR>
noremap <F7> :make test<CR>

" Better copy + paste
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
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

" Insert date
nnoremap <Leader>d "=strftime("%c")<CR>P"

nmap <Leader>m :call ToggleMouse()<CR>

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse
        set mouse=a
    endif
endfunc

function! ToggleGutter()
  :set invrelativenumber
endfunction

nnoremap <Leader>n :call ToggleGutter()<CR>

" Just easier commands
nnoremap <Leader>x :x<cr>
nnoremap <Leader>v :vspl<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>
