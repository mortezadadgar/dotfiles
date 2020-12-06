
" install vim-plug in case it's missing
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" /// Plug-ins ///
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'rakr/vim-one'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'gburca/vim-logcat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mcchrish/nnn.vim'
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

" switch between dark/light theme
map <F1> :set background=dark<CR>
map <F2> :set background=light<CR>

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
            \ 'coc-snippets',
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
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
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
