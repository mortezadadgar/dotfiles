local ts_input = require("mini.surround").gen_spec.input.treesitter
require("mini.surround").setup {
	n_lines = 250,
	respect_selection_type = true,
	search_method = "cover_or_next",
	custom_surroundings = {
		t = { input = ts_input { outer = "@function.outer", inner = "@function.inner" } },
	},
}
