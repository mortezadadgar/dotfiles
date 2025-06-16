return {
	"echasnovski/mini.completion",
	dependencies = {
		"echasnovski/mini.snippets",
	},
	enabled = false,
	opts = {
		window = {
			signature = { border = "single" },
		},
		delay = { signature = 10 ^ 7 },
		fallback_action = "<C-n>",
	},
}
