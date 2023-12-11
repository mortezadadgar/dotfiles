return {
	"stevearc/oil.nvim",
	opts = function()
		vim.keymap.set("n", "<Space>fe", "<cmd>Oil<CR>", { desc = "Oil file explorer" })
		return {
			keymaps = {
				["l"] = "actions.select",
				["h"] = "actions.parent",
				["q"] = "actions.close",
			},
			skip_confirm_for_simple_edits = true,
		}
	end,
}
