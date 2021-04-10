" colorizer
lua require'colorizer'.setup()

" change configs and default white color
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_color_overrides = {
\ "white": {"gui": "#c0c0c0", "cterm": "NONE", "cterm16": "NONE" },
\}

" finally change to onedark
colorscheme onedark
