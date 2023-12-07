return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	enabled = false,
	keys = {
		{ "<Space>fe", "<cmd>Oil<CR>", desc = "Oil file explorer" },
	},
	opts = {
		keymaps = {
			["l"] = "actions.select",
			["h"] = "actions.parent",
			["q"] = "actions.close",
		},
		skip_confirm_for_simple_edits = true,
	},
}
