" Remap leader
let mapleader = "\<Space>"
set encoding=utf-8

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

silent!call plug#begin()

""" Theme ###
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'

Plug 'rakr/vim-two-firewatch'
let g:two_firewatch_italics=1

Plug 'reedes/vim-colors-pencil'
let g:pencil_terminal_italics = 1



""" Fuzzy Search ###
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

Plug 'rking/ag.vim', {'on': 'Ag'}
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



""" Neomake ###
Plug 'neomake/neomake'
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

let g:neomake_virtualtext_current_error = 0
let g:neomake_python_enabled_makers = ['pylint']

nmap ]w :lnext<CR>
nmap [w :lprev<CR>



""" Vim Surround ###
Plug 'tpope/vim-surround'



""" Airline ###
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#wordcount#filetypes =
\ ['help', 'markdown', 'text', 'pandoc', 'tex', 'mail']

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



""" Nerd Commenter ###
Plug 'scrooloose/nerdcommenter'
map <C-_> <Leader>c<space>



""" Git integration ###
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>i
map <Leader>gd :Gdiff<CR>



""" Goyo ###
Plug 'junegunn/goyo.vim'
nnoremap <leader>go :Goyo <CR>
let g:goyo_width=70
let g:goyo_height=100



""" Pencil ###
Plug 'reedes/vim-pencil'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,vimwiki,text,tex call pencil#init()
augroup END
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
let g:pencil#conceallevel = 0
let g:pencil#textwidth = 74


""" Ditto ###
Plug 'dbmrq/vim-ditto'



""" Snippets ###
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"



""" Nerdtree ###
Plug 'scrooloose/nerdtree'
map <C-\> :NERDTreeToggle<CR>



""" Startify ###
Plug 'mhinz/vim-startify'



""" Zettelkasten ###
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:vimwiki_list = [{'path': '~/zettelkasten',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0
let g:vimwiki_conceallevel=0
augroup vimwiki_syntax
  au!
  autocmd FileType vimwiki cd %:p:h
  "autocmd FileType vimwiki TemplateInit vimwiki
  autocmd FileType vimwiki set syntax=markdown
augroup END

function! s:get_fzf_filename(line)
  " the filename is separated by : from rest of the line
  let parts =  split(a:line,":")
  " we need to remove the extension
  let filename = parts[0]
  return filename
endfunction

function! s:wiki_search(line)
  let filename = <sid>get_fzf_filename(a:line)
  let parts = split(filename,'\.')
  let filename_wo_ext = parts[0]
  echo filename_wo_ext
  "execute 'normal! a[['.filename_wo_ext.']]'
  execute 'normal! a['.filename_wo_ext.']('.filename_wo_ext.')'
endfunction

" make fulltext search in all VimWiki files using FZF
command! -bang -nargs=* ZettelSearch call fzf#vim#files(<q-args>, {
      \'down': '~40%',
      \'sink':function('<sid>wiki_search')})

"command! -bang -nargs=* ZettelSearch call fzf#vim#ag(<q-args>,
      "\'--skip-vcs-ignores', {
      "\'down': '~40%',
      "\'sink':function('<sid>wiki_search'),
      "\'options':'--exact'})

augroup zettelkasten
  au!
  au FileType vimwiki nnoremap <silent> <Plug>ZettelSearchMap :ZettelSearch<cr>
  au FileType vimwiki imap <silent> [[ <esc><Plug>ZettelSearchMap
augroup end

function! s:new_wiki_page(name)
  echo a:name
  execute "e ".fnameescape(a:name).".md"
  :TemplateInit vimwiki
endfunction

command! -nargs=* Wnew call s:new_wiki_page(<q-args>)



""" Templates ###
Plug 'tibabit/vim-templates'
let g:tmpl_auto_initialize=0
let g:tmpl_search_paths = ['~/.vim/templates']



""" pandoc ###
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#spell#enabled = 0
let g:pandoc#folding#fdc = 0
augroup pandoc_syntax
  au!
  autocmd FileType pandoc set syntax=pandoc
augroup END



""" Markdown ###
Plug 'jkramer/vim-checkbox' " Checkbox manipulation
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_frontmatter = 1



""" Tabularize ###
Plug 'godlygeek/tabular'
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif



""" Latex ###
Plug 'lervag/vimtex'
Plug 'hisaknown/deoplete-latex'
let g:tex_flavor='latex'
let g:vimtex_fold_enabled = 1



""" Python ###
Plug 'vim-scripts/indentpython.vim'



" Neovim only plugins
if has('nvim')
  """ deoplete ###
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
else
  """ Neocomplete ###
  Plug 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1
endif

call plug#end()

" Enable colorscheme
syntax enable
set background=dark
if has("patch-7.4-1799") || has("nvim")
  set termguicolors
  "colorscheme solarized8
  colorscheme two-firewatch
  let g:airline_theme='twofirewatch'
  "colorscheme pencil
  "let g:airline_theme='pencil'
else
  colorscheme solarized
endif

let python_highlight_all=1

" Spelling
set spelllang=en_gb
au FileType markdown,text,tex,vimwiki,pandoc call ToggleSpelling()
function! FixSpellingHighlighting()
  hi clear SpellBad
  hi clear SpellLocal
  hi clear SpellRare
  hi clear SpellCap
  hi link SpellRare ErrorMsg
  hi SpellBad gui=underline
  hi SpellLocal gui=underline
  hi SpellCap gui=underline
endfunction

function! ToggleSpelling()
  set spelllang=en_gb invspell
  ToggleDitto
  call FixSpellingHighlighting()
endfunction

" Enable/Disable spellchecker
noremap <silent> <Leader>s :call ToggleSpelling()<CR>

" Set detection, indentation & plugin load for filetypes
filetype plugin indent on
" Fix sloppy linux
set backspace=indent,eol,start
" Tab stuff
set tabstop=2 expandtab shiftwidth=2
"Concealling off
set conceallevel=0
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
let @/ = ""
" disable folding
"set nofoldenable
set foldmethod=expr
set foldlevel=2
" gvim stuff
set guifont=Cousine\ Regular\ 12
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guicursor=
" Fix clipboard
set clipboard^=unnamed,unnamedplus
" Fix airline over ssh
set laststatus=2
" Disable autocommenting
au FileType * set fo-=r fo-=o

" Show whitespace
set listchars=tab:>-,trail:· nolist!
nnoremap <silent> <Leader>w :set nolist!<CR>

" Open up a terminal
noremap <Leader>tt :vspl<cr><C-W><C-L>:term fish<cr>i

" Remap to beginning/end of line
noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

" Call make
noremap <F6> :make<CR>
noremap <F7> :make test<CR>

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
nnoremap <Leader>d "=strftime("%FT%T%z")<CR>P"

""" Mouse toggling ###
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

nmap <Leader>m :call ToggleMouse()<CR>

""" Gutter toggling ###
function! ToggleGutter()
  :set invrelativenumber
  :set invnumber
endfunction

nnoremap <Leader>n :call ToggleGutter()<CR>

""" Background toggling ###
let g:markdown_mode="false"
function! ToggleBackground()
  if g:markdown_mode == "false"
    :let g:markdown_mode = "true"
    :set background=light
    :colorscheme pencil
    :let g:airline_theme = 'pencil'
  else
    :let g:markdown_mode = "false"
    :set background=dark
    :colorscheme two-firewatch
    :let g:airline_theme = 'twofirewatch'
  endif
endfunction

nnoremap <Leader>b :call ToggleBackground()<CR>

" Just easier commands
nnoremap <Leader>v :vspl<cr><C-W><C-L>
nnoremap <Leader>h <C-W><C-S><C-W><C-J>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>
nnoremap vv viw
