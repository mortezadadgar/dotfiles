" Vim-plug
call plug#begin('~/.vim/plugged')
	" Comment lines
	Plug 'tpope/vim-commentary'
	
	" Git
	Plug 'tpope/vim-fugitive'
	
	" Colorscheme
	Plug 'joshdick/onedark.vim'
	
	" LSP & Completition
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'
	
	" Formatting
	Plug 'sbdchd/neoformat'

	" File manager
	Plug 'mcchrish/nnn.vim'
call plug#end()

" Load LSP config
lua << EOF
require('lsp')
EOF

" General settings
set number relativenumber
set hidden
set nohlsearch
set clipboard=unnamedplus
set nobackup noswapfile
set pumheight=10
set nofoldenable
set noshowmode
set updatetime=300
set splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4
set completeopt=menuone,noinsert,noselect
set smartindent
set scrolloff=8
set showbreak=↪
set nowrap

" Colors
set termguicolors
colorscheme onedark

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Display comments and strings in italic style
highlight Comment cterm=italic gui=italic
highlight String cterm=italic gui=italic

" Statusline
let g:currentmode={
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ "\<C-v>" : 'V·BLOCK',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'c'  : 'COMMAND',
       \}

set statusline+=\ %{g:currentmode[mode()]}
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=\ %{&spell?'[SPELL]':''}
set statusline+=\ %y
set statusline+=\ \|\ %l:%L\ 
set statusline+=\|
set statusline+=\ W:%{LSPWarnings()}\ 
set statusline+=E:%{LSPErrors()}\ 

fun LSPErrors()
    let errs = luaeval('vim.lsp.diagnostic.get_count(0, "Error")')
    return errs
endfun

fun LSPWarnings()
    let warns = luaeval('vim.lsp.diagnostic.get_count(0, "Warning")')
    return warns
endfun

" Statusline colors
au InsertEnter * hi statusline guifg=#98c379 " Green
au InsertLeave * hi statusline guifg=#61afef " Blue
hi statusline guifg=#61afef " Blue

" Neoformat
augroup FORMATTER
	autocmd!
    autocmd Filetype go,sh,py autocmd BufWritePre * Neoformat
augroup END

" Mappings
" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Perform dot commands over visual blocks
vnoremap . :normal .<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Replace the current word under the cursor
nnoremap <leader>rn :%s/<C-r><C-w>/<C-r><C-w>/g<left><left>

" Vim-plug
nnoremap <silent> <leader>pi :PlugInstall<CR>
nnoremap <silent> <leader>pc :PlugClean<CR>
nnoremap <silent> <leader>pu :PlugUpdate<CR>
