return {
	"saghen/blink.cmp",
	enabled = false,
	dependencies = {
		"L3MON4D3/LuaSnip",
	},
	version = "*",
	opts = {
		keymap = { preset = "enter" },
		sources = {
			default = {
				"snippets",
				"lsp",
				"buffer",
				"path",
			},
		},
		snippets = { preset = "luasnip" },
		completion = {
			menu = { border = "none" },
			documentation = {
				auto_show = true,
			},
		},
	},
}
