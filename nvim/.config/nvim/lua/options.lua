-- Appearances
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.signcolumn = "number"
vim.opt.showmode = false
vim.opt.winborder = "single"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Completion menu
vim.opt.pumheight = 10
vim.opt.completeopt = "menuone,popup,noselect,fuzzy"
vim.opt.shortmess:append "c"

-- Wild menu
vim.opt.wildignorecase = true
vim.opt.wildoptions:append { "fuzzy" }

-- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Save undo files
vim.opt.undofile = true

-- Disable highlighting all search matches
vim.opt.hlsearch = false

-- Spell checking
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""

-- Splitting new window behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Ask for confirmation of unsaved buffers
vim.opt.confirm = true

-- Change terminal cursor shape to vertical
vim.opt.guicursor:append { "t:ver25-TermCursor" }

-- Better diff options
vim.opt.diffopt:append {
	"indent-heuristic",
	"algorithm:histogram",
	"followwrap",
	"vertical",
	"foldcolumn:0",
}

-- Attempt to perverse mark view
vim.opt.jumpoptions:append { "view" }

-- Min number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 4

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_fastbrowse = 2

-- TODO: st not supporting csi 2031
-- vim.opt.background = "dark"
