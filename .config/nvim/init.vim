runtime! archlinux.vim

" /// Plug-ins ///
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'mhinz/vim-startify'
Plug 'itchyny/vim-gitbranch'
Plug 'psliwka/vim-smoothie'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" /// FzF ///
" Enable per-command history.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1

" key-binding
map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


" /// Startify ///
" startify banner
let g:startify_custom_header = [
	\ '  _   _ ______ ______      _______ __  __ ',
	\ ' | \ | |  ____/ __ \ \    / /_   _|  \/  |',
	\ ' |  \| | |__ | |  | \ \  / /  | | | \  / |',
	\ ' | . ` |  __|| |  | |\ \/ /   | | | |\/| |',
	\ ' | |\  | |___| |__| | \  /   _| |_| |  | |',
	\ ' |_| \_|______\____/   \/   |_____|_|  |_|',
	\ ]
                                          
                                          
" where we should save sessions
let g:startify_session_dir = '~/.config/nvim/session'

" statify main screen items
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ ]

" some configs I kanged from a guy
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0

" fast way back to home
nnoremap <leader>h :SClose<CR>

" /// Rnvimr ///
" Make Ranger to be hidden after picking a file
let g:rnvimr_pick_enable = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_bw_enable = 1

nmap " :RnvimrToggle<CR>

" Customize ranger window
let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"'

" Customize floating size
let g:rnvimr_presets = [
            \ {'width': 0.800, 'height': 0.600}]

" /// QuickScope ///
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=150

" /// Lightline ///
set noshowmode
set updatetime=300
set cmdheight=2

let g:lightline = {
        \ 'colorscheme': 'onedark',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified',
	\	        'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'gitbranch#name',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
	\ }
	\ }

let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ [''] ]
  \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" lightline-ale
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline#ale#indicator_warnings = "\uf071 "

" /// colorscheme ///
" 24-bit color
set termguicolors

" OneDark
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 16
let g:onedark_terminal_italics = 1
colorscheme onedark

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

" Use TAB to switch between tabs instead of gt/gT
" nmap <Tab> :tabnext<CR>
" nmap <S-Tab> :tabprevious<CR>

" /// ALE/Deoplete ///
let g:ale_linters = {
      \   'python': ['pylint', 'flake8'],
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
