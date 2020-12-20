" install vim-plug in case it's missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" /// Plug-ins ///
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'gburca/vim-logcat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mcchrish/nnn.vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'Raimondi/delimitMate'
call plug#end()

" /// Statusline ///
set noshowmode
set updatetime=300
set cmdheight=2

" Airline configurations
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0

" Human readable Line number
function! MyLineNumber()
  return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' / '.
    \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction
call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})
let g:airline_section_z = airline#section#create(['linenr'])

" /// colorscheme ///
set termguicolors
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
let g:onedark_color_overrides = {
\ "white": {"gui": "#c0c0c0", "cterm": "NONE", "cterm16": "NONE" },
\}
colorscheme onedark
hi VertSplit guibg=bg guifg=bg

" /// Basic ///
set number relativenumber
set incsearch nohlsearch
set nobackup nowb noswapfile
set cursorline
set clipboard=unnamedplus
set pumheight=10
set colorcolumn=80
set nofoldenable
set expandtab
set shortmess=filnxtToOFI
set splitbelow splitright

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

" /// KeyMapping ///
" Disable q:
nnoremap q: <nop>

" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Disable arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" Disable help menu
no <F1> <Nop>
ino <F1> <Nop>

" map :W to :w, same for :Q
command! W :w
command! Q :q

" Replace ex mode with gq
map Q gq

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Mapping for sideways
nmap <Leader>h :SidewaysLeft<CR>
nmap <Leader>l :SidewaysRight<CR>

let mapleader="\<Space>"

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" /// NNN ///
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

let g:nnn#layout = { 'window': { 'width': 0.5, 'height': 0.6, 'xoffset': 40, 'highlight': 'Debug', 'border': 'sharp' } }

" open nnn in current file's directory
nnoremap <C-n> :Np %:p:h<CR>

" nnn default options
let g:nnn#command = 'nnn -Ruex'

" /// COC ///
let g:coc_global_extensions = [
            \ 'coc-python',
            \ 'coc-sh',
            \ 'coc-go'
            \]

" Disable completion scratch
set completeopt-=preview

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" /// delimitMate ///
let delimitMate_expand_cr = 2
