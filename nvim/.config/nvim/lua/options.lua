vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "number"
vim.opt.winborder = "single"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.breakindent = true
vim.opt.pumheight = 10
vim.opt.wildignorecase = true
vim.opt.wildoptions:append { "fuzzy" }
vim.opt.wildmode:append "full:lastused"
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""
vim.opt.splitbelow = true
vim.opt.confirm = true
vim.opt.jumpoptions:append { "view" }
vim.opt.scrolloff = 4
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25" -- disable cursor blinking and vertical line shape for fzf
-- vim.opt.completeopt = { "noselect", "menuone", "fuzzy", "popup" }
-- vim.opt.autocomplete = true
