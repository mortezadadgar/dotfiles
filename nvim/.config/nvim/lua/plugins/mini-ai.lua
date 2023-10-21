local ai = require "mini.ai"
local spec_treesitter = ai.gen_spec.treesitter
ai.setup {
	custom_textobjects = {
		f = spec_treesitter { a = "@function.outer", i = "@function.inner" },
		C = spec_treesitter { a = "@class.outer", i = "@class.inner" },
		c = spec_treesitter { a = "@conditional.outer", i = "@conditional.inner" },
	},
}
