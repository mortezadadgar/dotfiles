local treesitter = require("nvim-treesitter.configs")

-- Treesitter setup
treesitter.setup({
	ensure_installed = {
		"markdown",
		"comment",
		"bash",
		"c",
		"go",
		"python",
		"lua",
		"javascript",
		"html",
		"css",
	},
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
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
})
