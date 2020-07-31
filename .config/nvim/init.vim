runtime! archlinux.vim

" /// Plug-ins ///
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'rakr/vim-one'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-dispatch'
call plug#end()

" /// Statusline ///
set noshowmode
set updatetime=300
set cmdheight=2

let g:airline_theme='one'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_symbols.linenr = '☰'
let g:airline_section_z = '%{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#/%L%'

" stop Rooter echoing the project directory
let g:rooter_silent_chdir = 1

" /// colorscheme ///
" 24-bit color
set termguicolors

" OneDark
colorscheme one

" /// Basic ///
" line number
set number relativenumber

" search
set incsearch nohlsearch

" no backup/swap
set nobackup nowb noswapfile

" cursorline
set cursorline

" No mouse, sorry
set mouse=

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" copy paste setting
set clipboard=unnamedplus

" Makes popup menu smaller
set pumheight=10

" set python binary
let g:python3_host_prog='/usr/bin/python3'

" /// KeyMapping ///
" Disable q:
nnoremap q: <nop>

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Better indenting
vnoremap < <gv
vnoremap > >gv

" compile python code
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Disable arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" switch between dark/light theme
map <F1> :set background=dark<CR>
map <F2> :set background=light<CR>

" Fzf
nnoremap <C-t> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :GFiles?<CR>

" /// ALE/Deoplete ///
let g:ale_linters = {
      \   'python': ['pylint', 'flake8'],
      \   'c': [],
      \   'h': [],
      \   'S': [],
      \ }

let g:ale_fixers = {
      \   'python': ['black', 'isort'],
      \ }

" formatting on save
let g:ale_fix_on_save = 1

" ALE sign
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:ale_completion_enabled = 0

" deplote width
call deoplete#custom#source('_',  'max_menu_width', 50)

" Disable completion scratch
set completeopt-=preview

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" nvigate between linters error
nmap <silent> ]g :ALENext<CR>
nmap <silent> [g :ALEPrevious<CR>
