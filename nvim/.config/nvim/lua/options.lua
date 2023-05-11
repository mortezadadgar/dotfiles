local set = vim.o

set.number = true
set.relativenumber = true
set.hlsearch = false
set.clipboard = "unnamedplus"
set.splitbelow = true
set.showmode = false
set.tabstop = 4
set.shiftwidth = 4
set.shiftwidth = 4
set.backup = false
set.swapfile = false
set.undotree = os.getenv "XDG_DATA_HOME" .. "/nvim/undotree"
set.undofile = true
set.smartindent = true
set.signcolumn = "number"
set.termguicolors = true
set.cursorline = true
set.lazyredraw = true
set.scrolloff = 8
set.updatetime = 300
set.pumheight = 10
set.breakindent = true
set.laststatus = 3
set.title = true
set.ignorecase = true
set.smartcase = true
set.mouse = ""
set.path = "**"
set.spelllang = "en_us"
set.conceallevel = 2
-- set.statusline = "[%n] %t%m%=%l:%L"
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
