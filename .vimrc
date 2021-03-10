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
Plug 'sonph/onehalf', { 'rtp': 'vim' }

""" Thematic ###
Plug 'reedes/vim-thematic'

""" Fuzzy Search ###
Plug 'ctrlpvim/ctrlp.vim'

""" Vim Surround ###
Plug 'tpope/vim-surround'

""" Airline ###
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" Nerd Commenter ###
Plug 'scrooloose/nerdcommenter'

""" Git integration ###
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

""" Goyo ###
Plug 'junegunn/goyo.vim'

""" Pencil ###
Plug 'reedes/vim-pencil'

""" Snippets ###
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

""" Nerdtree ###
Plug 'scrooloose/nerdtree'

""" Tabularize ###
Plug 'godlygeek/tabular'

""" Startify ###
Plug 'mhinz/vim-startify'

""" Zettelkasten ###
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

""" pandoc ###
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

""" Markdown ###
Plug 'jkramer/vim-checkbox' " Checkbox manipulation

""" Jekyll ###
Plug 'parkr/vim-jekyll'

""" Todo.txt """
Plug 'freitass/todo.txt-vim'

""" Latex ###
Plug 'lervag/vimtex'

""" Python ###
Plug 'vim-scripts/indentpython.vim'

""" Bracket autocomplete ###
Plug 'tmsvg/pear-tree'

""" Terraform ###
Plug 'hashivim/vim-terraform'

""" Tmux """
"Plug 'christoomey/vim-tmux-navigator'

""" Save views of folds ###
"Plug 'senderle/restoreview'

""" LSP
Plug 'natebosch/vim-lsc'
Plug 'ajh17/VimCompletesMe'

if has('nvim')
  Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
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

""" Ctrlp ###
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

""" pear-tree ###
let g:pear_tree_repeatable_expand = 0

""" LSP ###
set shortmess-=F
set completeopt=menu,menuone,noinsert,noselect
let g:lsc_server_commands = {'python': 'pyls'}
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}
let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:true
let g:lsc_reference_highlights = v:false
let g:lsc_trace_level          = 'off'

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

""" vim-jekyll ###
let g:jekyll_post_extension = '.md'

""" Nerdtree ###
map <C-\> :NERDTreeToggle<CR>

""" Zettelkasten ###
let g:vimwiki_list = [{'path': '~/zettelkasten',
		     \ 'syntax': 'markdown', 'index': 'readme', 'ext': '.md'}]
let g:vimwiki_global_ext=0
let g:vimwiki_conceallevel=0
let g:zettel_format = "%Y-%m-%d-%H-%M"
let g:zettel_dir = "~/zettelkasten"
let g:zettel_options = [{"front_matter" : {"source" : "%source"}}]
noremap <Leader>zb :ZettelNewBibtex<CR>

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

fu WikiSearchCurrentWord()
  let l:word = expand("<cword>")
  call WikiSearch_fn(l:word, 0)
endfu

fu WikiSearch_fn(word, timer)
  echom a:word
  execute 'WikiSearch '.a:word
endfu

function DelayedWikiSearch_fn(word)
    call timer_start(1, function('WikiSearch_fn', [a:word]))
endfunction

nnoremap <C-F> :call WikiSearchCurrentWord()<CR>

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
  "autocmd FileType vimwiki Thematic light
  autocmd FileType vimwiki command ZettelNewBibtex call ZettelNewBibtex_fn()
  au FileType vimwiki cd %:p:h

  if !exists('g:zettel_synced')
    let g:zettel_synced = 0
  else
    finish
  endif

  " execute vim function. because vimwiki can be started from any directory,
  " we must use pushd and popd commands to execute git commands in wiki root
  " dir. silent is used to disable necessity to press <enter> after each
  " command. the downside is that the command output is not displayed at all.
  function! s:git_action(action)
    execute ':!pushd ' . g:zettel_dir . "; ". a:action . "; popd"
    " prevent screen artifacts
    redraw!
  endfunction

  " pull changes from git origin using asynchronous jobs
  " we should add some error handling
  function! s:pull_changes()
    if g:zettel_synced==0
      let g:zettel_synced = 1
      let gitjob = jobstart("git -C " . g:zettel_dir . " pull origin master", {"exit_cb": "My_exit_cb", "close_cb": "My_close_cb"})
    endif
  endfunction

  " sync changes at the start
  au! VimEnter ~/zettelkasten/*.md call <sid>pull_changes()
  " commit and push changes only on at the end
  au! VimLeave ~/zettelkasten/*.md call <sid>git_action("git add *.md; git commit -m \"Auto commit\"; git push origin master")
augroup END

function! ZettelNewBibtex_fn()
  let bibtex = @+

  let title_regex = 'title = {\(\zs.\{-}\ze\)},'
  let title = matchstr(bibtex, title_regex)
  let title = escape(title, ":")
  let title = substitute(title, "[{}]", "", "g")

  let author_regex = 'author = {\zs.\{-}\ze}'
  let author = matchstr(bibtex, author_regex)
  let tagged_authors = substitute(author, '\(\w\{-}\),', '@\1,', 'g')

  let article_type_regex = '@\zs.\{-}\ze{'
  let article_type = matchstr(bibtex, article_type_regex)
  let tag = '#' . article_type

  let url_regex = 'url = {\zs.\{-}\ze}'
  let url = matchstr(bibtex, url_regex)

  let doi_regex = 'doi = {\zs.\{-}\ze}'
  let doi = matchstr(bibtex, doi_regex)

  if doi
    let url = "https://doi.org/" . doi
  endif
  let url = escape(url, "/\"")

  execute 'ZettelNew' title

  execute '%s/%source/' . url . '/'
  call append('$', tag . " by " . tagged_authors)
endfunction

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
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

""" vim-checkbox ###
map <silent> <leader>x :call checkbox#ToggleCB()<cr>

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
"set nofoldenable
set foldmethod=syntax foldlevel=1
let fortran_fold_conditionals=1
let fortran_fold=1
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
nnoremap <Leader>d "=strftime("%FT%T%z")<CR>p"

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
nnoremap <Leader>h <C-W><C-S><C-W><C-J>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>
nnoremap vv viw

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Fortran options
let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1
