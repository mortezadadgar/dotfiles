require("mini.pairs").setup {
	mappings = {
		['"'] = { neigh_pattern = "[^\\]%W" },
		["'"] = { neigh_pattern = "[^\\]%W" },
		["`"] = { neigh_pattern = "[^\\]%W" },
	},
}
