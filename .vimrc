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
Plug 'rakr/vim-two-firewatch'
Plug 'reedes/vim-colors-pencil'

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
" Git wrapper
Plug 'tpope/vim-fugitive'
" Searching
Plug 'rking/ag.vim', {'on': 'Ag'}
" Writing mode
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'dbmrq/vim-ditto'
" Better repeat
Plug 'tpope/vim-repeat'
" More % matching
"Plug 'vim-scripts/matchit.zip'
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" tree view
Plug 'scrooloose/nerdtree'
" Change vim's starting screen
Plug 'mhinz/vim-startify'

" Zettelkasten
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'michal-h21/vim-zettel'
"Plug 'jamiejquinn/vim-zettel'

" Markdown Preview
"Plug 'JamshedVesuna/vim-markdown-preview'

" vim-templates
Plug 'tibabit/vim-templates'

" Markdown image paste
Plug 'ferrine/md-img-paste.vim'

" pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Checkbox manipulation for markdown
Plug 'jkramer/vim-checkbox'

" FILETYPE STUFF
Plug 'pangloss/vim-javascript'
Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
"Plug 'tpope/vim-markdown'
Plug 'lervag/vimtex'
Plug 'hisaknown/deoplete-latex'
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

" Firewatch settings
let g:two_firewatch_italics=1

" Pencil theme settings
let g:pencil_terminal_italics = 1

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

" Templates
let g:tmpl_auto_initialize=0
let g:tmpl_search_paths = ['~/.vim/templates']

" Sets syntax + indentation per filetype
let python_highlight_all=1
filetype plugin indent on

" Vimwiki
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

" Deoplete
let g:deoplete#enable_at_startup = 1

" neocomplete
let g:neocomplete#enable_at_startup = 1

" Utilsnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"

" fzf
"map <C-p> :FZF<cr>
" fzf returns selected filename and matched line from the file, we need to
" strip that
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

" CtrlP stuff
" Ignore everything in .gitignore:
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"map <C-b> :CtrlPMRUFiles<cr>

" Markdown Preview
"let vim_markdown_preview_hotkey='<C-m>'
"let vim_markdown_preview_browser='Firefox'
"let vim_markdown_preview_toggle=1
"let vim_markdown_preview_temp_file=1
"let vim_markdown_preview_use_xdg_open=1

" Fugitive
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>i
map <Leader>gd :Gdiff<CR>

" Pandoc
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#spell#enabled = 0
let g:pandoc#folding#fdc = 0
augroup pandoc_syntax
  au!
  "autocmd FileType vimwiki TemplateInit vimwiki
  autocmd FileType pandoc set syntax=pandoc
augroup END

" Latex
let g:tex_flavor='latex'
let g:vimtex_fold_enabled = 1

" NERDCommenter Stuff
map <C-_> <Leader>c<space>

" NERDTree
map <C-\> :NERDTreeToggle<CR>

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
let g:airline#extensions#tabline#enabled = 1
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

" Set markdown properly
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_frontmatter = 1

" Ditto
"augroup ditto
  "au!
  "au FileType markdown,text,tex,vimwiki DittoOn
"augroup end

" Pencil
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,vimwiki,text,tex call pencil#init()
augroup END
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
let g:pencil#conceallevel = 0
let g:pencil#textwidth = 74

" markdown-img-paste
augroup markdown_image_paste
  au!
  autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
augroup end
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'copy-paste-image'

" Writers mode
"map <F10> :Goyo <bar> call ToggleBackground() <CR>
"map <F10> :Goyo <CR>
nnoremap <leader>go :Goyo <CR>

" Goyo
let g:goyo_width=70
let g:goyo_height=100

" Spelling
set spelllang=en_gb
"au FileType markdown,text,tex,vimwiki set spell
function! FixSpellingHighlighting()
  hi clear SpellBad
  hi clear SpellLocal
  hi clear SpellRare
  hi clear SpellCap
  "hi link SpellBad Error
  "hi link SpellLocal Error
  "hi link SpellCap Error
  hi link SpellRare ErrorMsg
  hi SpellBad gui=underline
  hi SpellLocal gui=underline
  hi SpellCap gui=underline
  "hi SpellRare gui=underline
endfunction

"" Markdown colorscheme tweaks
"" Change headings
"hi clear markdownHeadingDelimiter
"hi link markdownHeadingDelimiter modeMsg
"hi link htmlH1 NONE
"hi clear htmlH2
"hi clear htmlH3
"hi clear htmlH4
"hi clear htmlH5
"hi clear htmlH6
"" Remove annoying URL colours
""hi clear markdownUrl
""hi link markdownUrl Comment
""hi clear mkdLinkDefTarget
""hi clear mkdLinkDef
""hi clear mkdLink
"hi link markdownLinkText NONE
"hi link markdownId NONE
"hi link markdownUrlTitle NONE
"hi link markdownLinkDelimiter Comment
"hi link markdownLinkTextDelimiter Comment
"" Change footnote
"hi link markdownFootnote Type
"hi link markdownFootnoteDefinition Type
"" Change horizontal rule
"hi link markdownRule markdownListMarker

"hi Italic gui=italic cterm=italic
"hi link markdownItalic Italic

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
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12
" set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guicursor=
" Fix airline over ssh
set laststatus=2
" Disable autocommenting
au FileType * set fo-=r fo-=o

" Show whitespace
set listchars=tab:>-,trail:· nolist!
nnoremap <silent> <Leader>w :set nolist!<CR>

function! ToggleSpelling()
  set spelllang=en_gb invspell
  ToggleDitto
  call FixSpellingHighlighting()
endfunction

" Enable/Disable spellchecker
noremap <silent> <Leader>s :call ToggleSpelling()<CR>

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
vnoremap <Leader>y "+y
"nnoremap <Leader>p "+p
"vnoremap <Leader>p "+p

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
nnoremap <leader>ll <C-W><C-L>
nnoremap <leader>hh <C-W><C-H>

" Buffer switching
map <C-L> :bnext<cr>
map <C-H> :bprevious<cr>
map <leader>bq :bd <BAR> bd #<cr>

" Insert date
nnoremap <Leader>d "=strftime("%FT%T%z")<CR>P"

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

nnoremap <Leader>n :call ToggleGutter()<CR>

" Just easier commands
nnoremap <Leader>x :x<cr>
nnoremap <Leader>v :vspl<cr><C-W><C-L>
nnoremap <Leader>h <C-W><C-S><C-W><C-J>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>e :e#<cr>
nnoremap vv viw
