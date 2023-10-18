require("oil").setup {
	keymaps = {
		["<M-l>"] = "actions.select",
		["<M-h>"] = "actions.parent",
		["-"] = "actions.close",
	},
}
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
