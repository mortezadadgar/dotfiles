vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.showmode = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.signcolumn = "number"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.pumheight = 10
vim.opt.breakindent = true
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.jumpoptions = "view"
vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.laststatus = 3
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.diffopt:append {
	"indent-heuristic",
	"algorithm:patience",
	"foldcolumn:0",
}
