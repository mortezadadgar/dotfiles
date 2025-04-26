return {
	"saghen/blink.cmp",
	dependencies = {
		"echasnovski/mini.snippets",
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
		snippets = { preset = "mini_snippets" },
		cmdline = { enabled = false },
		completion = {
			menu = { border = "none" },
			-- list = { selection = { preselect = false, auto_insert = true } },
			documentation = {
				auto_show = true,
			},
		},
	},
}
