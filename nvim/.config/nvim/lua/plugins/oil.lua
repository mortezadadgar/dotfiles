return {
	"stevearc/oil.nvim",
	opts = function()
		vim.keymap.set("n", "-", "<cmd>Oil<CR>")
		return {
			keymaps = {
				["l"] = "actions.select",
				["h"] = "actions.parent",
				["q"] = "actions.close",
			},
			cleanup_delay_ms = 1000,
			skip_confirm_for_simple_edits = true,
		}
	end,
}
