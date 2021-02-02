" install vim-plug in case it's missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plug-ins
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mcchrish/nnn.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sheerun/vim-polyglot'
call plug#end()
" ---

" --- Basic
set number relativenumber
set hidden
set nohlsearch
set nobackup noswapfile
set cursorline
set clipboard=unnamedplus
set pumheight=10
set nofoldenable
set splitbelow splitright
set noshowmode
set updatetime=300
set tabstop=4 softtabstop=4 shiftwidth=4
set smartindent
set completeopt-=preview shortmess+=c signcolumn=yes
set termguicolors
set scrolloff=8
set colorcolumn=80

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically delete newlines at end of file on save
autocmd BufWritePre * %s/\n\+\%$//e

" display comments and strings in italic style
highlight Comment cterm=italic gui=italic
highlight String cterm=italic gui=italic
" ---

" --- KeyMaps
" Change a few annoying keys
nnoremap q: <nop>
nnoremap <F1> <nop>
inoremap <F1> <nop>
command! W :w

" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" replace the current word under the cursor
nnoremap <leader>m :%s/<C-r><C-w>//g<left><left>
nnoremap <leader>rn :%s/<C-r><C-w>/<C-r><C-w>/g<left><left>
" ---
