vim.o.number = true
vim.o.relativenumber = true
vim.o.hlsearch = false
vim.o.clipboard = "unnamedplus"
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.undofile = true
vim.o.smartindent = true
vim.o.signcolumn = "number"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.pumheight = 10
vim.o.breakindent = true
vim.o.title = true
vim.o.smartcase = true
vim.o.spelllang = "en_us"
vim.o.spelloptions = "camel"
vim.o.updatetime = 500
vim.o.completeopt = "menuone,noselect"
vim.o.laststatus = 3
vim.o.wildignorecase = true
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep --smart-case -g '!{**/node_modules/*}'"
vim.wo.colorcolumn = "80"
vim.g.netrw_banner = 0
vim.opt.wildignore:append {
	"*node_modules/**",
	".git/",
	"*.svg",
	"*.png",
	"*.ttf",
	"*.jpg",
}
