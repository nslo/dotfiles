" Plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'rhysd/vim-clang-format'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer && ln -s /usr/lib/libclang.so libclang.so' }
" Syntax
Plug 'tikhomirov/vim-glsl'
Plug 'wting/rust.vim'
" Haskell
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'yogsototh/haskell-vim'
call plug#end()

set shell=/bin/bash " To make vim-gitgutter work with Fish

" Colors
filetype on
filetype plugin indent on
syntax enable
"colorscheme gummybears_trans
colorscheme hybrid_trans
hi CursorLine term=bold cterm=bold gui=bold ctermbg=black guibg=black
set cursorline

" 80 character indicator
if exists('+colorcolumn')
    set colorcolumn=81
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif
hi ColorColumn ctermbg=4

" Trim trailing whitespace
autocmd FileType c,cpp,haskell autocmd BufWritePre <buffer> :%s/\s\+$//e

" Spellcheck
hi clear SpellBad
hi clear SpellCap
hi SpellBad cterm=bold ctermfg=red ctermbg=black

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
set incsearch " highlight as search string is typed
set nohlsearch " don't highlight searched terms after search completed
set showcmd
set autoread " auto update when file changed from outside
set t_Co=256
"set undofile
set hidden " allows modified buffers to be hidden
"set completeopt-=preview

" Keymappings
nnoremap <F1> <nop>
inoremap <F1> <nop>
nnoremap <C-t> <nop>
inoremap <C-t> <nop>
nnoremap <Q> <nop>
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
    \ "AccessModifierOffset" : -4,
    \ "AllowShortFunctionsOnASingleLine" : "Empty",
    \ "AllowShortBlocksOnASingleLine" : "true", 
    \ "AlwaysBreakTemplateDeclarations" : "true",
    \ "BinPackArguments" : "false",
    \ "BreakBeforeBraces" : "Linux",
    \ "BreakConstructorInitializersBeforeComma" : "true",
    \ "ConstructorInitializerAllOnOneLineOrOnePerLine" : "true",
    \ "PointerAlignment" : "Right",
    \ "SpacesBeforeTrailingComments" : 1,
    \ "Standard" : "C++11"}

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_enable_diagnostic_signs = 0 "Don't like gutter constantly coming and going.
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_key_detailed_diagnostics = '<leader>n'
let g:ycm_goto_buffer_command = 'same-buffer'
let g:ycm_global_ycm_extra_conf='~/Code/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']} "neco-ghc

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_always_populate_loc_list = 1

" CtrlP
nmap <leader>c :CtrlP<cr>
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

" Haskell
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hh :GhcModTypeClear<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>
" Auto-checking on writing
autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync
"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
" yogsotoh/haskell-vim
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
