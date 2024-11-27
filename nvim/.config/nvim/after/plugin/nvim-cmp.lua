local cmp = require "cmp"
require("cmp").setup {
	mapping = cmp.mapping.preset.insert(),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{
			name = "buffer",
			keyword_length = 2,
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
	},
	preselect = cmp.PreselectMode.None,
}
