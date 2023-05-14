local actions = require "telescope.actions"
require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = { "%.svg", "%.jpg", "%.png" },
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
}
