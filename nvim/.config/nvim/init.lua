-- enable fast loader
vim.loader.enable()

require "paq" {
	"savq/paq-nvim",
	{ "rose-pine/neovim", as = "rose-pine" },
	"stevearc/conform.nvim",
	"j-hui/fidget.nvim",
	"ibhagwan/fzf-lua",
	"echasnovski/mini.icons",
	"echasnovski/mini.completion",
	"echasnovski/mini.snippets",
	"echasnovski/mini.hipatterns",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"mbbill/undotree",
	"tpope/vim-sleuth",
}

--
-- Plugin configs
--

-- default colorscheme
vim.cmd.colorscheme "rose-pine"

-- Undotree
vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_SetFocusWhenToggle = 1
vim.keymap.set("n", "<space>u", "<cmd>UndotreeToggle<CR>")

-- Fidget
require("fidget").setup()

-- Conform
do
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
		notify_on_error = false,
		format_on_save = function()
			-- Stop if we disabled auto-formatting.
			if not vim.g.autoformat then
				return nil
			end

			return { timeout_ms = 500, lsp_fallback = true }
		end,
	}

	-- Use conform for gq
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	-- Start auto-formatting by default (and disable with my ToggleFormat command).
	vim.g.autoformat = true
end

-- Fzf-Lua
do
	local delta_preview = "delta --width=$COLUMNS --syntax-theme base16 --diff-highlight"
	require("fzf-lua").setup {
		-- keep the fzf process running in background, allow for a richer `:FzfLua resume`
		"hide",

		fzf_opts = {
			["--layout"] = "default",
			["--no-scrollbar"] = "",
			["--history"] = vim.fn.stdpath "data" .. "/fzf-lua-history",
		},
		previewers = {
			git_diff = {
				pager = delta_preview,
			},
			builtin = {
				extensions = {
					["png"] = { "ueberzug" },
					["jpg"] = { "ueberzug" },
					["jpeg"] = { "ueberzug" },
					["webp"] = { "ueberzug" },
				},
				ueberzug_scaler = "cover",
			},
		},
		winopts = {
			preview = {
				scrollbar = false,
			},
		},
		files = {
			cwd_prompt = false,
			prompt = "Files> ",
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
		git = {
			commits = {
				preview_pager = delta_preview,
			},
			bcommits = {
				preview_pager = delta_preview,
			},
			stash = {
				preview_pager = delta_preview,
			},
			blame = {
				preview_pager = delta_preview,
			},
		},
		lsp = {
			includeDeclaration = false,
		},
		oldfiles = {
			cwd_only = true,
		},
		buffers = {
			cwd_only = true,
			ignore_current_buffer = true,
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

	local fzf = require "fzf-lua"

	vim.keymap.set("n", "<space><space>", fzf.files, { desc = "FZF: Find Files" })
	vim.keymap.set("n", "<space>gg", fzf.live_grep_glob, { desc = "FZF: Live grep" })
	vim.keymap.set("n", "<space>gs", fzf.grep_cword, { desc = "FZF: Grep Word under cursor" })
	vim.keymap.set("x", "<space>gs", fzf.grep_visual, { desc = "FZF: Grep Word under cursor" })
	vim.keymap.set("n", "<space>b", fzf.buffers, { desc = "FZF: buffers" })
	vim.keymap.set("n", "<space>o", fzf.oldfiles, { desc = "FZF: Oldfiles" })
	vim.keymap.set("n", "<space>gt", fzf.git_status, { desc = "FZF: Git Status" })
	vim.keymap.set("n", "<space>?", fzf.help_tags, { desc = "FZF: Help Tags" })
	vim.keymap.set("n", "<space>m", function()
		fzf.marks { marks = "%a" }
	end, { desc = "FZF: Global Marks" })
	vim.keymap.set("n", "<space>tb", fzf.tmux_buffers, { desc = "FZF: Tmux buffers" })
	vim.keymap.set("n", "<leader><leader>", fzf.resume, { desc = "FZF: Resume" })
	vim.keymap.set("n", "<space>/", fzf.grep_curbuf, { desc = "FZF: grep current buffer" })
	vim.keymap.set("n", "z=", fzf.spell_suggest, { desc = "FZF: Spell Suggest" })

	vim.keymap.set("n", "<space>cc", function()
		fzf.files {
			cwd = vim.fn.expand "%:h",
		}
	end, { desc = "FZF: Find Files current buffer directory" })

	vim.keymap.set("n", "<space>cf", function()
		fzf.files {
			cwd = "$HOME/.config",
			prompt = "Config Files> ",
			follow = true,
		}
	end, { desc = "FZF: Find Config Files" })
end

-- Mini plugins
do
	require("mini.snippets").setup()

	require("mini.completion").setup {
		window = {
			signature = { border = "single" },
		},
		delay = { signature = 10 ^ 7 },
	}

	local imap_expr = function(lhs, rhs)
		vim.keymap.set("i", lhs, rhs, { expr = true })
	end

	imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
	imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

	local keys = {
		["cr"] = vim.keycode "<CR>",
		["ctrl-y"] = vim.keycode "<C-y>",
		["ctrl-y_cr"] = vim.keycode "<C-y><CR>",
	}

	_G.cr_action = function()
		if vim.fn.pumvisible() ~= 0 then
			local item_selected = vim.fn.complete_info()["selected"] ~= -1
			return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
		else
			return keys["cr"]
		end
	end

	vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

	local minicons = require "mini.icons"
	minicons.setup()
	minicons.tweak_lsp_kind()

	require("mini.hipatterns").setup {
		highlighters = {
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "DiagnosticError" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "DiagnosticHint" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "DiagnosticInfo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "DiagnosticWarn" },
			done = { pattern = "%f[%w]()DONE()%f[%W]", group = "SpecialChar" },
			hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
		},
	}
end

-- Lsp server config
do
	local servers = {
		gopls = {
			settings = {
				gopls = {
					codelenses = {
						gc_details = true,
						test = true,
					},
					-- usePlaceholders = true,
					analyses = {
						unusedparams = true,
						nilness = true,
						unusedwrite = true,
						unusedvariable = true,
						useany = true,
					},
					gofumpt = true,
					staticcheck = true,
				},
			},
		},
		lua_ls = {
			settings = {
				Lua = {
					telemetry = {
						enable = false,
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
						},
					},
				},
			},
		},
		rust_analyzer = {
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
						extraArgs = { "--", "-Wclippy::pedantic" },
					},
				},
			},
		},
		vtsls = {
			settings = {
				vtsls = {
					autoUseWorkspaceTsdk = true,
					experimental = {
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
				},
			},
		},
		svelte = {},
		-- ts_ls = {},
		html = {},
		cssls = {},
		tailwindcss = {},
		jsonls = {},
		eslint = {},
		pyright = {},
		clangd = {},
		typos_lsp = {},
		bashls = {},
		marksman = {},
	}

	local capabilities =
		vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), MiniCompletion.get_lsp_capabilities())

	for server, config in pairs(servers) do
		require("lspconfig")[server].setup {
			capabilities = capabilities,
			settings = config.settings,
		}
	end
end

-- Treesitter configs
do
	require("nvim-treesitter.configs").setup {
		ensure_installed = {
			"markdown_inline",
		},

		ignore_install = {
			"ini",
			"vim",
			"sql",
			"tmux",
		},

		auto_install = true,

		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},
	}

	require("nvim-treesitter.configs").setup {
		textobjects = {
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
			select = {
				enable = true,
				keymaps = {
					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	}
end

--
-- Options
--

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

--
-- User commands
--

vim.api.nvim_create_user_command("ToggleFormat", function()
	vim.g.autoformat = not vim.g.autoformat
	vim.notify(string.format("%s formatting", vim.g.autoformat and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Toggle conform.nvim auto-formatting", nargs = 0 })

--
-- Remaps
--

-- C-c  is not quite same as Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Indent while remaining in visual mode
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Shift visual selections
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Alias :W to saving files
vim.keymap.set("ca", "W", "w")

-- spell check
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<cr>", { desc = "Toggle spell checking" })

-- gF is just better
vim.keymap.set("n", "gf", "gF")

-- Select last inserted text
vim.keymap.set("n", "gV", "`[v`]", { desc = "Select last inserted text" })

-- Repeat last command for each line of a visual selection
vim.keymap.set("x", ".", ":normal .<cr>", { silent = true })

--
-- Automatic commands
--

local group = vim.api.nvim_create_augroup("UserGroup", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank and set tmux buffer",
	group = group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
		vim.system { "tmux", "set-buffer", "-w", vim.fn.getreg [["]] }
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	desc = "Resize splits if window got resized",
	group = group,
	command = "tabdo wincmd =",
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

--
-- Status line
--

require "statusline"

--
-- LSP config
--

vim.diagnostic.config {
	virtual_text = {
		source = "if_many",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local opts = { buffer = args.buf }
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client == nil then
			return
		end

		vim.keymap.set({ "i", "s" }, "<C-S>", function()
			if vim.fn.pumvisible() ~= 0 then
				vim.api.nvim_feedkeys(vim.keycode "<C-e>", "n", true)
			end
			vim.lsp.buf.signature_help()
		end)

		local ok, fzf = pcall(require, "fzf-lua")
		if ok then
			vim.keymap.set("n", "grq", fzf.lsp_document_diagnostics, opts)
			vim.keymap.set("n", "gO", fzf.lsp_document_symbols, opts)
			vim.keymap.set("n", "grr", fzf.lsp_references, opts)
		end
	end,
})
