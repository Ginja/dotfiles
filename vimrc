syntax on
filetype on
filetype plugin on
filetype indent on
" Search as you type
set incsearch
" Highlight search terms
set hlsearch
set ignorecase
set smartcase
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
set hidden
set history=1000
set wildmenu
set wildmode=list:longest
set title
set scrolloff=3
set ruler
set visualbell
set smartindent
set autoindent
set tabstop=4
set shiftwidth=2
set expandtab
" Save your changes even if you forget to use sudo
cmap w!! w !sudo tee > /dev/null %
" Remove search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
