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

hi CursorLine cterm=None ctermbg=darkblue ctermfg=white guibg=darkblue guifg=white
set cursorline
