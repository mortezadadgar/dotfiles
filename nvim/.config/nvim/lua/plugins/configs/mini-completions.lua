-- TAB completion
vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

require("mini.completion").setup {
	window = {
		signature = { height = 25, width = 80, border = "single" },
		info = { height = 1, width = 1 },
	},
}
