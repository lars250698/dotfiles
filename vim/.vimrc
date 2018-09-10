syntax enable
set background=dark
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
Plug 'w0rp/ale'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'dylanaraps/wal.vim'
call plug#end()

"vim-airline"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline_symbols.space = "\ua0"
let g:airline_theme='powerlineish'

colorscheme wal
