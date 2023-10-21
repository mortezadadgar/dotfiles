require("oil").setup {
	keymaps = {
		["<M-l>"] = "actions.select",
		["<M-h>"] = "actions.parent",
	},
}
vim.keymap.set("n", "<Space>fe", "<cmd>Oil<CR>", { desc = "Open parent directory" })
