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

"colorscheme twilight
"colorscheme grb256
"colorscheme jellybeans_trans
colorscheme gummybears_trans

hi CursorLine term=bold cterm=bold gui=bold ctermbg=black guibg=black
set cursorline

set ignorecase
set smartcase
set incsearch
set showcmd

set t_Co=256

nnoremap <F1> <nop>
inoremap <F1> <nop>
nnoremap <C-t> <nop>
inoremap <C-t> <nop>

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
