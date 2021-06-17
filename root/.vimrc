call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'rust-lang/rls'
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
Plug 'altercation/vim-colors-solarized'

call plug#end()

syntax enable
set background=dark
colorscheme solarized

" colorscheme OceanicNext

set nu
set rnu
set ignorecase

filetype plugin indent on
