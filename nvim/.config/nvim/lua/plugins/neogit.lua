return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<space>ng", "<cmd>Neogit<CR>" },
	},
	opts = {
		disable_hint = true,
		signs = {
			item = { "", "" },
			section = { "", "" },
		},
		integrations = {
			telescope = true,
		},
		telescope_sorter = function()
			return require("telescope").extensions.fzf.native_fzf_sorter()
		end,
	},
}
