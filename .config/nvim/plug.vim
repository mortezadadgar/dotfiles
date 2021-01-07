" --- Plug-ins ---
" install vim-plug in case it's missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mcchrish/nnn.vim'
Plug 'Raimondi/delimitMate'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'dracula/vim'
call plug#end()

" --- Airline ---
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_nr = 0

" Human readable Line number
function! MyLineNumber()
  return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' / '.
    \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction
call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})
let g:airline_section_z = airline#section#create(['linenr'])

" --- Colors ---
" enable 24-bit colors
set termguicolors

" setup colorizer
lua require'colorizer'.setup()

" change configs and default white color
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_color_overrides = {
\ "white": {"gui": "#c0c0c0", "cterm": "NONE", "cterm16": "NONE" },
\}

" finally change to onedark
colorscheme onedark

" fix foreground operator cursorline
" hi! link Operator GruvboxFg1

" --- NNN ---
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

" nnn floating window
let g:nnn#layout = { 'window': { 'width': 0.5, 'height': 0.6, 'xoffset': 40, 'highlight': 'Debug', 'border': 'sharp' } }

" open nnn in current file's directory
nnoremap <C-n> :Np<CR>

" nnn default options
let g:nnn#command = 'nnn -Ruex'

" --- COC ---
let g:coc_global_extensions = [
            \ 'coc-python',
            \ 'coc-go'
            \]

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

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)

" --- delimitMate ---
let delimitMate_expand_cr = 2
let delimitMate_matchpairs = "(:),[:],{:}"
