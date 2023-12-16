vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignorecase = true
vim.opt.pumheight = 10
vim.opt.completeopt = "menuone,noselect"
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.scrolloff = 4
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.signcolumn = "number"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars = {
	fold = " ",
	foldsep = " ",
	foldopen = "",
	foldclose = "",
	diff = "╱",
	eob = " ",
	msgsep = "─",
}
vim.opt.diffopt:append {
	"indent-heuristic",
	"algorithm:patience",
}
