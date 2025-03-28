-- Appearances
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.signcolumn = "number"
vim.opt.laststatus = 3
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
vim.opt.completeopt = { "popup", "menuone", "noinsert", "fuzzy" }
vim.opt.wildignorecase = true

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
	"algorithm:patience",
}

-- Attempt to perverse mark view
vim.opt.jumpoptions:append { "view" }

-- Min number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4
