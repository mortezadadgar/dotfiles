-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- save undo history
vim.opt.undofile = true

-- ignore case
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignorecase = true

-- wrap lines at words
vim.opt.breakindent = true

-- set window title
vim.opt.title = true

-- annoying features
vim.opt.swapfile = false
vim.opt.hlsearch = false

-- spell checking
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"

-- better scrolling experience
vim.opt.scrolloff = 4

-- UI settings
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.pumheight = 10
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.signcolumn = "number"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- make sure fsync is called on writes
-- remove when v0.10
vim.opt.fsync = true

-- use ripgrep for greping
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep --smart-case"

-- UI characters
vim.opt.fillchars = {
	diff = "╱",
	eob = " ",
	msgsep = "─",
}

-- better diff option
vim.opt.diffopt:append {
	"indent-heuristic",
	"algorithm:patience",
	"linematch:60",
	"foldcolumn:0",
}

-- make netrw behave sane
vim.g.netrw_banner = 0
vim.g.netrw_fastbrowse = 0
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_list_hide = [['\.\/']]
