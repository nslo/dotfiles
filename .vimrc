" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'gorkunov/smartpairs.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
call vundle#end()
filetype plugin indent on

" Colors
syntax enable
colorscheme gummybears_trans
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
hi SpellBad cterm=bold ctermfg=black ctermbg=red

" GVim options
if has('gui_running')
    set guioptions-=T " no toolbar
    set lines=66 columns=90
    colorscheme jellybeans
    "set guifont=consolas:h9
endif

" Other Vim options
set number
set lbr
set tabstop=4
set shiftwidth=4
set expandtab " turn tabs into spaces
" Ignore case when opening file in vim
set wildignorecase
" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu " completion with menu
set ignorecase " case insensitive searching
set smartcase " but become sensitive if you type uppercase
set incsearch "highlight as search string is typed
set showcmd
set autoread " auto update when file changed from outside
set t_Co=256
set undofile
set hidden " allows modified buffers to be hidden
"set completeopt-=preview

" Keymappings
nnoremap <F1> <nop>
inoremap <F1> <nop>
nnoremap <C-t> <nop>
inoremap <C-t> <nop>
nnoremap <Q> <nop>
inoremap <Q> <nop>
ca tn tabnew
let mapleader=","
" Get rest of line on Y
nnoremap Y y$
" Easy access to + register
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>Y "+Y
vmap <leader>Y "+Y
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
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme = 'murmur'

" clang-format
let g:clang_format#auto_format = 1
let g:clang_format#style_options = {
    \ "BreakBeforeBraces" : "Allman"}

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_enable_diagnostic_signs = 0 "Don't like gutter constantly coming and going.
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_key_detailed_diagnostics = '<leader>n'
let g:ycm_goto_buffer_command = 'new-tab'
let g:ycm_global_ycm_extra_conf='~/Code/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completion = 1

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" CtrlP
nmap <leader>p :CtrlP<cr>
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Buffergator / buffers
let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_suppress_keymaps = 1
" mru buffers
let g:buffergator_mru_cycle_loop = 1
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
nmap <leader>kk :BuffergatorMruCycleNext<cr>
" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>
" Open empty buffer
nmap <leader>T :enew<cr>
" Close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
