if has('gui_running')
    set guioptions-=T  " no toolbar
    set guioptions-=r  "remove right-hand scroll bar 
    colorscheme slate
    set lines=66 columns=90
endif

set number
set lbr

set tabstop=4
set shiftwidth=4
set expandtab

filetype on
filetype indent on
syntax enable

"colorscheme oceandeep

hi CursorLine term=bold cterm=bold gui=bold ctermbg=black guibg=black
set cursorline

set ignorecase
set smartcase
set incsearch
set showcmd

set t_Co=256
