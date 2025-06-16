return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"echasnovski/mini.snippets",
		"rafamadriz/friendly-snippets",
	},
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
		snippets = { preset = "default" },
		cmdline = { enabled = false },
		completion = {
			menu = { border = "none" },
			documentation = {
				auto_show = true,
			},
		},
	},
}
