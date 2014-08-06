" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
filetype plugin indent on
" fallback config file for ycm
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" GVim options
if has('gui_running')
    set guioptions-=T  " no toolbar
    set guioptions-=r  "remove right-hand scroll bar 
    colorscheme slate
    set lines=66 columns=90
endif

" Colors
syntax enable
colorscheme gummybears_trans
"autocmd Filetype python colorscheme railscasts256_trans
"autocmd Filetype haskell colorscheme railscasts256_trans
hi CursorLine term=bold cterm=bold gui=bold ctermbg=black guibg=black
set cursorline

" 80 character indicator                                                        
if exists('+colorcolumn')                                                       
    set colorcolumn=81                                                          
else                                                                            
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)             
endif                                                                           
hi ColorColumn ctermbg=4                                                        

" Spellcheck
hi clear SpellBad
hi clear SpellCap
hi SpellBad cterm=underline

" Other Vim options
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
set completeopt-=preview

" Keymappings
nnoremap <F1> <nop>
inoremap <F1> <nop>
nnoremap <C-t> <nop>
inoremap <C-t> <nop>
nnoremap <CapsLock> <nop>
inoremap <CapsLock> <nop>
nnoremap <Q> <nop>
inoremap <Q> <nop>
ca tn tabnew
let mapleader=","
" For youcompleteme
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Get rest of line on Y
nnoremap Y y$
" Easy access to + register
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>d "+d
vmap <leader>d "+d
nmap <leader>p "+p
vmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>P "+P
" Make cw consistent with dw, yw, vw
onoremap w :execute 'normal! '.v:count1.'w'<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
