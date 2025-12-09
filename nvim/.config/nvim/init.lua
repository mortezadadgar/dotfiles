local vim = vim -- suppress lsp warnings

-------------
-- Options --
-------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "number"
vim.opt.showmode = false
vim.opt.winborder = "single"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.pumheight = 10
vim.opt.completeopt = "menuone,popup,nosort,noselect,fuzzy"
vim.opt.shortmess:append "c"
vim.opt.wildignorecase = true
vim.opt.wildoptions:append { "fuzzy" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""
vim.opt.splitbelow = true
vim.opt.confirm = true
vim.opt.jumpoptions:append { "view" }
vim.opt.scrolloff = 4

--------------
-- Mappings --
--------------
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<cr>", { desc = "Toggle spell checking" })
vim.keymap.set("ca", "W", "w")
vim.keymap.set("n", "<space>b", "<cmd>ls t<cr>:buffer ")

vim.keymap.set("n", "<space><space>", "<cmd>Pick files<cr>", { desc = "Pick: Find Files" })
vim.keymap.set("n", "<space>g", "<cmd>Pick grep_live<cr>", { desc = "Pick: Live grep" })
vim.keymap.set("n", "<space>o", "<cmd>Pick oldfiles<cr>", { desc = "Pick: Oldfiles" })
vim.keymap.set("n", "<leader><leader>", "<cmd>Pick resume<cr>", { desc = "Pick: Resume" })
vim.keymap.set("n", "z=", "<cmd>Pick spellsuggest<cr>", { desc = "Pick: Spell Suggestions" })
vim.keymap.set("n", "-", "<cmd>=MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>", { desc = "File explorer" })

--------------
-- Autocmd  --
--------------
local group = vim.api.nvim_create_augroup("UserGroup", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank and set tmux buffer",
	group = group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()

		local reg = vim.fn.getreg [["]]
		local _, count = reg:gsub("\n", "\n")
		if count < 450 then
			vim.system { "tmux", "set-buffer", "-w", reg }
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disable auto commenting",
	group = group,
	callback = function()
		vim.opt.formatoptions:remove { "c", "r", "o" }
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Go to last loc when opening a buffer",
	group = group,
	callback = function(event)
		local buf = event.buf
		local exclude = { "gitcommit", "gitrebase" }
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-------------
-- Plugins --
-------------
vim.pack.add {
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.files",
	"https://github.com/nvim-mini/mini.notify",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/nvim-mini/mini.icons",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range "*" },
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/linrongbin16/gitlinker.nvim",
	"https://github.com/tpope/vim-fugitive",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
}

--------------------
-- Plugin configs --
--------------------
local function setup_lsp()
	vim.lsp.enable {
		"gopls",
		"lua_ls",
		"ts_ls",
		"svelte",
		"html",
		"cssls",
		"emmet_language_server",
		"tailwindcss",
		"typos_lsp",
	}

	vim.diagnostic.config {
		virtual_text = {
			source = "if_many",
		},
		severity_sort = true,
		status = {
			text = {
				[vim.diagnostic.severity.ERROR] = "✘",
				[vim.diagnostic.severity.WARN] = "▲",
				[vim.diagnostic.severity.HINT] = "⚑",
				[vim.diagnostic.severity.INFO] = "»",
			},
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "✘",
				[vim.diagnostic.severity.WARN] = "▲",
				[vim.diagnostic.severity.HINT] = "⚑",
				[vim.diagnostic.severity.INFO] = "»",
			},
		},
	}

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(ev)
			vim.keymap.set("n", "grq", "<cmd>Pick diagnostic scope='current'<cr>", { buffer = ev.buf, desc = "Diagnostic buffer" })
			vim.keymap.set("n", "grQ", "<cmd>Pick diagnostic<cr>", { buffer = ev.buf, desc = "Diagnostic workspace" })
			vim.keymap.set("n", "gO", "<cmd>Pick lsp scope='document_symbol'<cr>", { buffer = ev.buf, desc = "Symbols document" })
			vim.keymap.set("n", "grr", "<cmd>Pick lsp scope='references'<cr>", { buffer = ev.buf, desc = "LSP References" })
			vim.keymap.set("n", "gri", "<cmd>Pick lsp scope='implementation'<cr>", { buffer = ev.buf, desc = "LSP Implementation" })
		end,
	})
end

local function setup_treesitter()
	require("nvim-treesitter.configs").setup {
		ensure_installed = { "markdown_inline", "bash" },
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	}
end

local function setup_conform()
	require("conform").setup {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			yaml = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			go = { "goimports" },
			templ = { "templ" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	}
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

local function setup_blink()
	require("blink.cmp").setup {
		keymap = { preset = "enter" },
		sources = {
			default = {
				"lsp",
				"snippets",
				"buffer",
				"path",
			},
		},
		completion = {
			menu = {
				border = "none",
			},
			documentation = {
				auto_show = true,
			},
		},
	}
end

vim.cmd.colorscheme "rose-pine"

setup_lsp()
setup_treesitter()
setup_conform()
setup_blink()
require("mini.pick").setup()
require("mini.extra").setup()
require("mini.files").setup()
require("mini.notify").setup()
require("mini.icons").setup()
require("gitlinker").setup()
require("neoscroll").setup { duration_multiplier = 0.5 }
vim.cmd [[packadd nvim.undotree]]
