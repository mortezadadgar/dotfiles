require("mini.pairs").setup {
	mappings = {
		["("] = { neigh_pattern = "[^\\]%s" },
		["["] = { neigh_pattern = "[^\\]%s" },
		["{"] = { neigh_pattern = "[^\\]%s" },

		['"'] = { neigh_pattern = "[^%a\\][^%w%$]" },
		["'"] = { neigh_pattern = "[^%a\\][^%w%$]" },
		["`"] = { neigh_pattern = "[^%a\\][^%w%$]" },
	},
}
