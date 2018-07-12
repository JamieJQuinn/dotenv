" Remap leader
let mapleader = "\<Space>"
set encoding=utf-8

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

silent!call plug#begin()
" Theme
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'

" Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
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
" Better file management
Plug 'tpope/vim-vinegar'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Auto-brackets
Plug 'jiangmiao/auto-pairs'
" Searching
Plug 'rking/ag.vim', {'on': 'Ag'}
" Writing mode
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'dbmrq/vim-ditto'
" Better repeat
Plug 'tpope/vim-repeat'
" More % matching
Plug 'vim-scripts/matchit.zip'
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Zettelkasten
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jamiejquinn/vim-zettel'

" FILETYPE STUFF
Plug 'pangloss/vim-javascript'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'vim-scripts/indentpython.vim'

" Neovim only plugins
if has('nvim')
  " Code Completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  " Code Completion
  Plug 'Shougo/neocomplete.vim'
endif

call plug#end()

" Vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/zettelkasten/',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0 " Disable all md files being represented as vimwiki files
let g:vimwiki_conceallevel=0

" Deoplete
let g:deoplete#enable_at_startup = 1

" neocomplete
let g:neocomplete#enable_at_startup = 1

" Utilsnips
let g:UltiSnipsExpandTrigger="<tab>"

" CtrlP stuff
" Ignore everything in .gitignore:
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
map <C-r> :CtrlPMRUFiles<cr>

" Fugitive
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>i
map <Leader>gd :Gdiff<CR>

" Latex
let g:tex_flavor='latex'

" NERDCommenter Stuff
map <C-_> <Leader>c<space>

" Tabular
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

" Neomake
if has('nvim')
  autocmd! BufWritePost * Neomake
else
  nmap <Leader>l :Neomake<CR>
endif
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

let g:neomake_python_enabled_makers = ['pylint']

"let g:neomake_cpp_enabled_makers = []
"let g:neomake_cpp_clang_maker = {
   "\ 'exe': 'clang++',
   "\ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion', '-Wno-pragma-once-outside-header'],
   "\ }

nmap ]w :lnext<CR>
nmap [w :lprev<CR>

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

" airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_section_y = '%{PencilMode()}'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

" Set markdown properly
let g:vim_markdown_folding_disabled = 1
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_frontmatter = 1

" Ditto
au FileType markdown,text,tex,vimwiki DittoOn

" Spelling
au FileType markdown,text,tex,vimwiki set spell

" Pencil
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType vimwiki         call pencil#init()
  autocmd FileType text         call pencil#init()
  autocmd FileType tex         call pencil#init()
augroup END
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
let g:pencil#conceallevel = 0
let g:pencil#textwidth = 74

" Writers mode
map <F10> :Goyo <bar> :call ToggleBackground() <CR>

" Enable solarized theme
syntax enable
set background=dark
let g:user_bg="dark"
if has("patch-7.4-1799") || has("nvim")
  set termguicolors
  colorscheme solarized8
else
  colorscheme solarized
endif

" Fix sloppy linux
set backspace=indent,eol,start

" Tab stuff
set tabstop=2 expandtab shiftwidth=2

" Sets syntax + indentation per filetype
let python_highlight_all=1
filetype plugin indent on

" Disable hard wrapping
set formatoptions-=t
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
" gvim stuff
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guicursor=
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
" Spelling
set spelllang=en_gb
" Fix airline over ssh
set laststatus=2
" Disable autocommenting
au FileType * set fo-=r fo-=o

" Show whitespace
set listchars=tab:>-,trail:· nolist!
nnoremap <silent> <Leader>w :set nolist!<CR>

" Enable/Disable spellchecker
noremap <silent> <Leader>s :set spelllang=en_gb invspell<CR>

" Open up a terminal
noremap <Leader>tt :vspl<cr><C-W><C-L>:term fish<cr>i

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
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

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
  :set invnumber
endfunction

function! ToggleBackground()
  if g:user_bg == "light"
    :set background=dark
    :let g:user_bg="dark"
  else
    :set background=light
    :let g:user_bg="light"
  endif
endfunction

nnoremap <Leader>n :call ToggleGutter()<CR>

" Just easier commands
nnoremap <Leader>x :x<cr>
nnoremap <Leader>v :vspl<cr><C-W><C-L>
nnoremap <Leader>h <C-W><C-S><C-W><C-J>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>
