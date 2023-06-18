local treesitter = require "nvim-treesitter.configs"

require("treesitter-context").setup()

-- Treesitter setup
treesitter.setup {
	ensure_installed = {
		"markdown",
		"markdown_inline",
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

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "+",
			node_incremental = "<BS>",
			scope_incremental = "=",
			node_decremental = "-",
		},
	},
}
