return {
	"stevearc/oil.nvim",
	opts = function()
		vim.keymap.set("n", "-", "<cmd>Oil<CR>")
		return {
			keymaps = {
				["q"] = "actions.close",
			},
			skip_confirm_for_simple_edits = true,
			lsp_file_methods = {
				autosave_changes = true,
			},
		}
	end,
}
