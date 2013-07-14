"execute pathogen#infect()

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
filetype plugin indent on
" fallback config file for ycm
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Normal VIM stuff
if has('gui_running')
    set guioptions-=T  " no toolbar
    set guioptions-=r  "remove right-hand scroll bar 
    colorscheme slate
    set lines=66 columns=90
endif

"filetype on
"filetype indent on
syntax enable

colorscheme gummybears_trans
autocmd Filetype python colorscheme railscasts256_trans
autocmd Filetype haskell colorscheme railscasts256_trans
hi CursorLine term=bold cterm=bold gui=bold ctermbg=black guibg=black
set cursorline

set number
set lbr
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set smartcase
set incsearch
set showcmd
set autoread
set t_Co=256

nnoremap <F1> <nop>
inoremap <F1> <nop>
nnoremap <C-t> <nop>
inoremap <C-t> <nop>
ca tn tabnew
