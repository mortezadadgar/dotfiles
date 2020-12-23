" --- Plug-ins ---
source $HOME/.config/nvim/plug.vim

" --- Basic ---
set number relativenumber
set incsearch nohlsearch
set nobackup nowb noswapfile
set cursorline
set clipboard=unnamedplus
set pumheight=10
set colorcolumn=80
set nofoldenable
set shortmess=filnxtToOFI
set splitbelow splitright
set noshowmode
set updatetime=300
set completeopt-=preview shortmess+=c signcolumn=yes

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" default syntax for files with no extention and *.rc
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=log | endif
autocmd BufNewFile,BufRead *.rc set syntax=log

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" display comments and strings in italic style
highlight Comment cterm=italic gui=italic
highlight String cterm=italic gui=italic

" --- KeyMaps ---
" Change a few annoying keys
nnoremap q: <nop>
no <F1> <Nop>
ino <F1> <Nop>
command! W :w
command! Q :q
command! Qa :qa
map Q gq
let mapleader="\<Space>"

" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Disable arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>
