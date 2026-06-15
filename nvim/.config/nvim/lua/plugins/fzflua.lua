vim.pack.add {
	{ src = "https://github.com/ibhagwan/fzf-lua" },
}

require("fzf-lua").setup {
	fzf_opts = {
		["--layout"] = "default",
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
			ueberzug_scaler = "cover",
		},
	},
	oldfiles = {
		cwd_only = true,
		winopts = {
			width = 90,
			height = 20,
			row = 0.5,
			col = 0.5,
			preview = {
				hidden = true,
			},
		},
	},
	buffers = {
		ignore_current_buffer = true,
		winopts = {
			width = 90,
			height = 20,
			row = 0.5,
			col = 0.5,
			preview = {
				hidden = true,
			},
		},
	},
	lsp = {
		code_actions = {
			winopts = {
				height = 0.5,
				width = 0.40,
				row = 1.5,
				relative = "cursor",
				preview = {
					hidden = true,
				},
			},
		},
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

vim.keymap.set("n", "<space><space>", "<cmd>FzfLua files<cr>", { desc = "FZF: Find Files" })
vim.keymap.set("n", "<space>g", "<cmd>FzfLua live_grep<cr>", { desc = "FZF: Live grep" })
vim.keymap.set("x", "<space>g", "<cmd>FzfLua grep_visual<cr>", { desc = "FZF: Live grep visually selected string" })
vim.keymap.set("n", "<space>o", "<cmd>FzfLua oldfiles<cr>", { desc = "FZF: Oldfiles" })
vim.keymap.set("n", "<space>b", "<cmd>FzfLua buffers<cr>", { desc = "FZF: Buffers" })
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua resume<cr>", { desc = "FZF: Resume" })
vim.keymap.set("n", "z=", "<cmd>FzfLua spell_suggest<cr>", { desc = "FZF: Spell Suggest" })

require("fzf-lua").register_ui_select()
