return {
	"mbbill/undotree",
	init = function()
		vim.g.undotree_DiffAutoOpen = 0
		vim.g.undotree_SetFocusWhenToggle = 1

		vim.keymap.set("n", "<space>u", "<cmd>UndotreeToggle<CR>")
	end,
}
