filetype plugin indent on

set mouse=a

set number
set ruler

" NERDTree Stuff
map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Stuff
map <C-_> <leader>c<space>

" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall                                                                                                      
endif                                                                                                                                 

call plug#begin()    
Plug 'altercation/vim-colors-solarized'
" Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
" vimrc defaults
Plug 'tpope/vim-sensible'
" Tree view
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" FILETYPE STUFF
Plug 'tpope/vim-rails'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'

call plug#end()
"
" Enable solarized theme
syntax enable
set background=dark
colorscheme solarized
