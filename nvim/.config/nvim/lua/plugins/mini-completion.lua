require("mini.completion").setup {
	fallback_action = "<C-x><C-n>",
	window = {
		signature = { border = "single" },
	},
	lsp_completion = {
		process_items = require("mini.fuzzy").process_lsp_items,
	},
}
