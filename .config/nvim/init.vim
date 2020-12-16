" install vim-plug in case it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" /// Plug-ins ///
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'gburca/vim-logcat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'Raimondi/delimitMate'
call plug#end()

" /// Statusline ///
set noshowmode
set updatetime=300
set cmdheight=2

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

" stop Rooter echoing the project directory
let g:rooter_silent_chdir = 1

" /// colorscheme ///
" 24-bit color
set termguicolors

" OneDark
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
let g:onedark_color_overrides = {
\ "white": {"gui": "#c0c0c0", "cterm": "NONE", "cterm16": "NONE" },
\}
colorscheme onedark
hi VertSplit guibg=bg guifg=bg

" /// Basic ///
" line number
set number relativenumber

" search
set incsearch nohlsearch

" no backup/swap
set nobackup nowb noswapfile

" cursorline
set cursorline

" Enable mouse for insert mode
set mouse=i

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" configure yank/paste
set clipboard=unnamedplus

" Make popup menu smaller
set pumheight=10

" max 80 line width
set colorcolumn=80

" default syntax for files with no extention and *.rc
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=log | endif
autocmd BufNewFile,BufRead *.rc set syntax=log

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" display comments and strings in italic style
highlight Comment cterm=italic gui=italic
highlight String cterm=italic gui=italic

" disable folding everywhere
set nofoldenable

" spaces instead of tabs
set expandtab

" Do not show startup message('I' flag)
set shortmess=filnxtToOFI

" Splits open at the bottom and right
set splitbelow splitright

" Set space as leader
let mapleader="\<Space>"

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

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

" disable mouse selection in insert mode
imap <LeftMouse> <nop>
imap <RightMouse> <nop>

" /// NNN ///
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

let g:nnn#layout = { 'window': { 'width': 0.4, 'height': 0.6, 'xoffset': 40, 'highlight': 'Debug', 'border': 'sharp' } }

" open nnn in current file's directory
nnoremap <C-n> :Np %:p:h<CR>

" open text files in $VISUAL
let g:nnn#command = 'nnn -e'

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" /// FZF ///
" show fzf in a splitted window
let g:fzf_layout = {'down': '~20%'}

" Hide airline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" disable preview window
let g:fzf_preview_window = []

" bindings
map <C-t> :Files<CR>
imap <C-t> :Files<CR>
map <C-b> :Buffers<CR>
imap <C-b> :Buffers<CR>

" /// delimitMate ///
let delimitMate_expand_cr = 2
