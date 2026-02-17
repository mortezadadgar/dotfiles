local gh = function(plugin, opts)
	return vim.tbl_extend("force", { src = "https://github.com/" .. plugin }, opts or {})
end

vim.pack.add {
	-- LSP
	gh "neovim/nvim-lspconfig",

	-- File Manager
	gh "nvim-mini/mini.files",

	-- Fuzzy Finder
	gh "ibhagwan/fzf-lua",

	-- Editing Tools
	gh("saghen/blink.cmp", { version = vim.version.range "*" }),
	gh "rafamadriz/friendly-snippets",
	gh "stevearc/conform.nvim",
	gh "kylechui/nvim-surround",
	gh "nvim-mini/mini.splitjoin",
	gh "nvim-mini/mini.ai",
	gh "windwp/nvim-ts-autotag",

	-- Treesitter
	gh "nvim-treesitter/nvim-treesitter",

	-- Git
	gh "tpope/vim-fugitive",
	gh "linrongbin16/gitlinker.nvim",
	gh "lewis6991/gitsigns.nvim",

	-- Appearance
	gh("rose-pine/neovim", { name = "rose-pine" }),
	gh "nvim-mini/mini.icons",
	gh "nvim-mini/mini.notify",
	gh "karb94/neoscroll.nvim",
	gh "stevearc/quicker.nvim",
}

-- pack event -----------------------------------------------------
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "vim.pack hook",
	group = vim.api.nvim_create_augroup("VimPackHook", {}),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.cmd ":TSUpdate"
		end
	end,
})

-- colorscheme ---------------------------------------------------
vim.cmd.colorscheme "rose-pine"

-- lspconfig -----------------------------------------------------
vim.lsp.enable {
	"gopls",
	"lua_ls",
	"ts_ls",
	"svelte",
	"html",
	"cssls",
	"biome",
	"jsonls",
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
	group = vim.api.nvim_create_augroup("LspAttachGroup", {}),
	callback = function(args)
		vim.keymap.set("n", "grq", "<cmd>FzfLua diagnostics_document<cr>", { buffer = args.buf, desc = "Diagnostic buffer" })
		vim.keymap.set("n", "grQ", "<cmd>FzfLua diagnostics_workspace<cr>", { buffer = args.buf, desc = "Diagnostic workspace" })
		vim.keymap.set("n", "gO", "<cmd>FzfLua lsp_document_symbols<cr>", { buffer = args.buf, desc = "Symbols document" })
		vim.keymap.set("n", "grr", "<cmd>FzfLua lsp_references<cr>", { buffer = args.buf, desc = "LSP References" })
		vim.keymap.set("n", "gri", "<cmd>FzfLua lsp_implementations<cr>", { buffer = args.buf, desc = "LSP Implementation" })
	end,
})

-- nvim-treesitter -----------------------------------------------------
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
		end)
	end,
})

-- conform.nvim -----------------------------------------------------
require("conform").setup {
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		svelte = { "prettier" },
		typescript = { "prettier" },
		yaml = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		go = { "goimports" },
		templ = { "templ" },
	},
	formatters = {
		-- Require a Prettier configuration file to format.
		prettier = {
			require_cwd = true,
		},
	},
	format_on_save = function()
		-- Stop if we disabled auto-formatting.
		if not vim.g.autoformat then
			return nil
		end

		return { timeout_ms = 1000, lsp_format = "fallback" }
	end,
}
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.g.autoformat = true

-- blink.cmp -----------------------------------------------------
require("blink.cmp").setup {
	keymap = { preset = "enter" },
	snippets = { preset = "default" },
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
		ghost_text = {
			enabled = false,
		},
		menu = {
			border = "none",
		},
		documentation = {
			auto_show = true,
		},
	},
}

-- fzf.lua -----------------------------------------------------
require("fzf-lua").setup {
	fzf_opts = {
		-- ["--layout"] = "default",
		["--history"] = vim.fn.stdpath "data" .. "/fzf-lua-history",
	},
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
	files = {
		actions = {
			["ctrl-y"] = {
				fn = function(selected)
					if #selected > 0 then
						local path = vim.split(selected[1], " ")[2]
						vim.fn.setreg([[+]], path)
					end
				end,
				header = "Copy Path",
				exec_silent = true,
			},
		},
	},
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
			["<C-e>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-e"] = "toggle-preview",
			["ctrl-d"] = "preview-page-down",
			["ctrl-u"] = "preview-page-up",
			["ctrl-q"] = "select-all+accept",
			["ctrl-j"] = "next-history",
			["ctrl-k"] = "previous-history",
			["ctrl-n"] = "down",
			["ctrl-p"] = "up",
		},
	},
}
require("fzf-lua").register_ui_select()

-- GitSigns -----------------------------------------------
require("gitsigns").setup {
	signcolumn = true,
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(buffer)
		local gitsigns = require "gitsigns"

		---@param mode string|string[]
		---@param lhs string
		---@param rhs string|function
		---@param desc? string
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = "Git: " .. desc })
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal { "]c", bang = true }
			else
				gitsigns.nav_hunk("next", { preview = true })
			end
		end, "Next hunk")

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal { "[c", bang = true }
			else
				gitsigns.nav_hunk("prev", { preview = true })
			end
		end, "previous hunk")

		-- Actions
		map("n", "ghh", gitsigns.stage_hunk, "stage hunk")
		map("n", "ghH", gitsigns.reset_hunk, "reset hunk")

		map("v", "ghh", function()
			gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
		end, "stage hunk")

		map("v", "ghH", function()
			gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
		end, "reset hunk")

		-- View
		map("n", "ghd", gitsigns.diffthis, "diff this")
		map("n", "ghb", gitsigns.blame, "blame")
		map("n", "ghp", gitsigns.preview_hunk, "preview hunk")

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk, "stage hung")
	end,
}

-- Other plugins -----------------------------------------------------
require("mini.files").setup()
require("mini.icons").setup()
require("mini.notify").setup()
require("mini.splitjoin").setup()
require("mini.ai").setup()
require("neoscroll").setup { duration_multiplier = 0.5 }
require("nvim-ts-autotag").setup()
require("gitlinker").setup()
require("nvim-surround").setup()
vim.cmd "packadd nvim.undotree"
