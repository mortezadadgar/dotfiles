require("mini.completion").setup {
	fallback_action = "<C-x><C-n>",
	window = {
		signature = { border = "single" },
	},
	delay = { signature = 10 ^ 7 },
}
