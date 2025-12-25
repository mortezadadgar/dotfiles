-------------
-- Options --
-------------
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
vim.opt.updatetime = 1000
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25" -- disable cursor blinking and vertical line shape for fzf

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
vim.keymap.set("n", "<space><space>", "<cmd>FzfLua files<cr>", { desc = "FZF: Find Files" })
vim.keymap.set("n", "<space>g", "<cmd>FzfLua live_grep<cr>", { desc = "FZF: Live grep" })
vim.keymap.set("x", "<space>g", "<cmd>FzfLua grep_visual<cr>", { desc = "FZF: Grep Word under cursor" })
vim.keymap.set("n", "<space>o", "<cmd>FzfLua oldfiles<cr>", { desc = "FZF: Oldfiles" })
vim.keymap.set("n", "<space>b", "<cmd>FzfLua buffers<cr>", { desc = "FZF: Buffers" })
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua resume<cr>", { desc = "FZF: Resume" })
vim.keymap.set("n", "z=", "<cmd>FzfLua spell_suggest<cr>", { desc = "FZF: Spell Suggest" })
vim.keymap.set("n", "-", "<cmd>=MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>", { desc = "File explorer" })
vim.keymap.set("n", "<space>u", "<cmd>Undotree<cr>", { desc = "Undotree" })

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

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "vim.pack hook",
	group = group,
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.cmd ":TSUpdate"
		end
	end,
})

-------------
-- Plugins --
-------------
vim.pack.add {
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.files",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/ibhagwan/fzf-lua",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range "*" },
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/nvim-treesitter/nvim-treesitter",
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
		"jsonls",
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
			vim.keymap.set("n", "grq", "<cmd>FzfLua diagnostics_document<cr>", { buffer = ev.buf, desc = "Diagnostic buffer" })
			vim.keymap.set("n", "grQ", "<cmd>FzfLua diagnostics_workspace<cr>", { buffer = ev.buf, desc = "Diagnostic workspace" })
			vim.keymap.set("n", "gO", "<cmd>FzfLua lsp_document_symbols<cr>", { buffer = ev.buf, desc = "Symbols document" })
			vim.keymap.set("n", "grr", "<cmd>FzfLua lsp_references<cr>", { buffer = ev.buf, desc = "LSP References" })
			vim.keymap.set("n", "gri", "<cmd>FzfLua lsp_implementations<cr>", { buffer = ev.buf, desc = "LSP Implementation" })
		end,
	})
end

local function setup_treesitter()
	vim.api.nvim_create_autocmd("FileType", {
		desc = "TreesitterAutoInstall",
		group = vim.api.nvim_create_augroup("TreesitterAutoInstall", {}),
		callback = function(ev)
			local ft = ev.match
			local buf = ev.buf

			if vim.bo[buf].buftype == "nofile" then
				return
			end

			local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
			if not ok then
				return
			end

			local parser = require("nvim-treesitter.parsers")[ft]
			if not parser then
				return -- no parser available
			end

			require("nvim-treesitter").install({ lang }):await(function()
				vim.treesitter.start(buf, lang)
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end)
		end,
	})
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
		cmdline = { enabled = false },
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

local function setup_fzf()
	require("fzf-lua").setup {
		previewers = {
			builtin = {
				extensions = {
					["png"] = { "chafa" },
					["jpg"] = { "chafa" },
					["jpeg"] = { "chafa" },
					["webp"] = { "chafa" },
					["svg"] = { "chafa" },
				},
			},
		},
		oldfiles = {
			cwd_only = true,
		},
		keymap = {
			builtin = {
				["<C-d>"] = "preview-page-down",
				["<C-u>"] = "preview-page-up",
			},
			fzf = {
				["ctrl-q"] = "select-all+accept",
			},
		},
	}
	require("fzf-lua").register_ui_select()
end

vim.cmd.colorscheme "rose-pine"

setup_lsp()
setup_treesitter()
setup_conform()
setup_blink()
setup_fzf()
require("mini.files").setup()
require("mini.icons").setup()
require("neoscroll").setup { duration_multiplier = 0.5 }
require("nvim-surround").setup()
vim.cmd [[packadd nvim.undotree]]
