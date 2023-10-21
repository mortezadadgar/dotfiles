-- Treesitter setup
require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"markdown_inline",
		"comment",
		"html",
		"css",
		"scss",
		"typescript",
	},

	ignore_install = {
		"ini",
		"vim",
	},

	auto_install = true,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			node_decremental = "<M-space>",
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = false,
			include_surrounding_whitespace = true,
			keymaps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_end = {
				["]]"] = "@function.outer",
			},
			goto_previous_start = {
				["[["] = "@function.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
}
