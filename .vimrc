" Remap leader
let mapleader = "\<Space>"
set encoding=utf-8

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

silent!call plug#begin()

Plug 'sonph/onehalf', { 'rtp': 'vim' } " Main theme
Plug 'reedes/vim-thematic' " Theme switcher
Plug 'junegunn/fzf' " Fuzzy finding
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround' " Manually create parenthases
Plug 'bling/vim-airline' " Info bar
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter' " Auto comments
Plug 'airblade/vim-gitgutter' " Git in gutter
Plug 'tpope/vim-fugitive' " Git commands
Plug 'scrooloose/nerdtree' " Tree view
Plug 'godlygeek/tabular' " Tabularise
Plug 'jkramer/vim-checkbox' " Checkboxes
Plug 'tmsvg/pear-tree' " Brackets completion
Plug 'mhinz/vim-startify' " Start page
Plug 'prabirshrestha/vim-lsp' " LSP
Plug 'mattn/vim-lsp-settings'

Plug 'junegunn/goyo.vim' " Lovely centred view
Plug 'junegunn/limelight.vim' " Nice highlighting for markdown
Plug 'reedes/vim-pencil' " Better wrapping

Plug 'vim-pandoc/vim-pandoc' " Pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex' " Latex
Plug 'parkr/vim-jekyll' " Jekyll
Plug 'freitass/todo.txt-vim' " Todo.txt
Plug 'vim-scripts/indentpython.vim' " Python
Plug 'hashivim/vim-terraform' " Terraform
Plug 'JuliaEditorSupport/julia-vim' " Julia

""" Snippets ###
if has('python3')
  Plug 'honza/vim-snippets'
  Plug 'SirVer/ultisnips'
endif

""" Zettelkasten ###
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

""" Theme ###
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let python_highlight_all=1

" Set detection, indentation & plugin load for filetypes
" This has to be called early
filetype plugin indent on

""" Thematic ###
let g:thematic#themes = {
\ 'dark' :{'colorscheme': 'onehalfdark',
\                 'background': 'dark',
\                 'airline-theme': 'onehalfdark',
\                },
\ 'light' :{'colorscheme': 'onehalflight',
\                 'background': 'light',
\                 'airline-theme': 'onehalflight',
\                },
\ }

colorscheme onehalfdark
let g:airline_theme='onehalfdark'

""" Distraction-free writing ###
function! DistractionFreeWriting()
    Thematic light
    Goyo
endfunction

""" FZF ###
map <C-p> :Files<CR>

""" pear-tree ###
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_ft_disabled = ['markdown', 'pandoc']

""" Deoplete ###
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})

""" LSP ###
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

""" Airline ###
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

""" todo.txt ###
let g:todo_done_filename = 'done.txt'

""" Nerd Commenter ###
map <C-_> <Leader>c<space>

""" Git integration ###
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>i
map <Leader>gd :Gdiff<CR>

""" Goyo ###
nnoremap <leader>go :Goyo <CR>
let g:goyo_width=70
let g:goyo_height=100

""" Pencil ###
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,vimwiki,text,tex call pencil#init()
augroup END
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
let g:pencil#conceallevel = 0
let g:pencil#textwidth = 74

""" Snippets ###
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-s>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/UltiSnips']

""" vim-jekyll ###
let g:jekyll_post_extension = '.md'

""" Nerdtree ###
map <C-\> :NERDTreeToggle<CR>

""" Zettelkasten ###
let g:vimwiki_list = [{
         \ 'path': '~/zettelkasten',
         \ 'syntax': 'markdown',
         \ 'index': 'readme',
         \ 'ext': '.md'}]
let g:vimwiki_global_ext=0
let g:vimwiki_conceallevel=0
"let g:zettel_format = "%Y-%m-%d-%H-%M"
let g:zettel_link_format="[[%link.md]]"
let g:zettel_dir = "~/zettelkasten"
let g:zettel_options = [{"front_matter" : {"source" : "%source"}}]
"noremap <Leader>zb :ZettelNewBibtex<CR>

""" FZF ###
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_preview_window = ['up:50%', 'ctrl-/']
let g:fzf_layout = { 'down': '100%' }

command! -bang -nargs=? -complete=dir WikiFiles
    \ call fzf#vim#ag("title:", {'options': ['-d:', '--with-nth=5']}, <bang>0)

command! -bang -nargs=* WikiSearch
    \ call fzf#vim#grep(
    \ "ag -l -- ".shellescape(<q-args>)." | xargs ag --no-heading --no-break title:", 0, 
    \ fzf#vim#with_preview({'options': ['-d:', '--with-nth=4..', '--preview-window', 'up:50%']}), <bang>0)

command! -bang -nargs=* WikiTags
    \ call fzf#run(
    \ {'source':"ag -o --no-heading --no-filename '#[a-zA-Z0-9\-]+' | sort -uf", 
    \ 'sink':function('DelayedWikiSearch_fn')})

command! -bang -nargs=* WikiAuthors
    \ call fzf#run(
    \ {'source':"ag -o --no-heading --no-filename '@[a-zA-Z0-9\-]+' | sort -uf", 
    \ 'sink':function('DelayedWikiSearch_fn')})

fu! WikiSearchCurrentWord()
  let l:word = expand("<cword>")
  call WikiSearch_fn(l:word, 0)
endfu

fu! WikiSearch_fn(word, timer)
  echom a:word
  execute 'WikiSearch '.a:word
endfu

function! DelayedWikiSearch_fn(word)
    call timer_start(1, function('WikiSearch_fn', [a:word]))
endfunction

nnoremap <C-F> :Ag<CR>

" Disable default keymappings
let g:zettel_default_mappings = 0 
" This is basically the same as the default configuration
augroup zettelkasten
  autocmd!
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
  autocmd FileType vimwiki xmap z <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap gZ <Plug>ZettelReplaceFileWithLink
  "autocmd FileType vimwiki nmap <C-F> :Ag<CR>
  autocmd FileType vimwiki set syntax=pandoc
  autocmd FileType vimwiki let b:pear_tree_pairs = {}
  "autocmd FileType vimwiki Thematic light
  "autocmd FileType vimwiki command ZettelNewBibtex call ZettelNewBibtex_fn()
  au FileType vimwiki cd %:p:h
augroup END

""" Pandoc ###
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#spell#enabled = 0
let g:pandoc#folding#fdc = 0
augroup pandoc_syntax
  au!
  autocmd FileType pandoc set syntax=pandoc
augroup END

""" Latex ###
let g:tex_flavor='latex'
let g:vimtex_fold_enabled = 1

""" Tabularize ###
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t| :Tabularize /|<CR>
  vmap <Leader>t| :Tabularize /|<CR>
endif

""" vim-checkbox ###
map <silent> <leader>x :call checkbox#ToggleCB()<cr>
let g:insert_checkbox_prefix = '- '

" Spelling
set spelllang=en_gb
set spellfile=~/.vim/spell/en.utf-8.add
au FileType markdown,text,tex,vimwiki,pandoc set spell

fun s:customSpellingHighlight()
  hi clear SpellLocal
  hi clear SpellCap
  hi link SpellLocal SpellBad
  hi link SpellCap SpellBad
endfun

augroup spelling
  autocmd!
  autocmd colorscheme * call s:customSpellingHighlight()
augroup END

noremap <silent> <Leader>s :set invspell<CR>

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
"set number
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
set nofoldenable
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
" Enable cursorline
set cursorline
" Disable command preview
"if has('nvim')
  "set inccommand=
"endif

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
  ":set invrelativenumber
  :set invnumber
endfunction

nnoremap <Leader>n :call ToggleGutter()<CR>

""" Background toggling ###
let g:markdown_mode="false"
function! ToggleBackground()
  if g:markdown_mode == "false"
    :let g:markdown_mode = "true"
    Thematic light
  else
    :let g:markdown_mode = "false"
    Thematic dark
  endif
endfunction

nnoremap <Leader>b :call ToggleBackground()<CR>

" Just easier commands
nnoremap <Leader>v :vspl<cr><C-W><C-L>
"nnoremap <Leader>h <C-W><C-S><C-W><C-J>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>e :e#<cr>
nnoremap vv viw
vnoremap <leader>p "_dP

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Fortran options
let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1
au BufNewFile,BufRead *.pf set filetype=fortran
