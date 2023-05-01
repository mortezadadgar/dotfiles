local treesitter = require "nvim-treesitter.configs"

require("treesitter-context").setup()

-- Treesitter setup
treesitter.setup {
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
		"org",
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
	},

	indent = {
		enable = true,
	},

	-- incremental_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = "<CR>",
	-- 		node_incremental = "<CR>",
	-- 		scope_incremental = "-",
	-- 		node_decremental = "grm",
	-- 	},
	-- },
}
