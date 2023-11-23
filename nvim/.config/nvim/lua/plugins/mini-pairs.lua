local pattern = "%W[^%$%w]"
require("mini.pairs").setup {
	mappings = {
		['"'] = { neigh_pattern = pattern },
		["'"] = { neigh_pattern = pattern },
		["`"] = { neigh_pattern = pattern },
		["("] = { neigh_pattern = pattern },
		["["] = { neigh_pattern = pattern },
		["{"] = { neigh_pattern = pattern },
	},
}
