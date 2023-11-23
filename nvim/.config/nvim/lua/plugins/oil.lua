require("oil").setup {
	keymaps = {
		["<C-v>"] = "actions.select_vsplit",
		["<C-x>"] = "actions.select_split",
		["l"] = "actions.select",
		["h"] = "actions.parent",
	},
}
vim.keymap.set("n", "<Space>fe", "<cmd>Oil<CR>")
