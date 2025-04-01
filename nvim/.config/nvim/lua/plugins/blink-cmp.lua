return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		keymap = { preset = "enter" },
		sources = {
			default = {
				"snippets",
				"lsp",
				"buffer",
				"path",
			},
			providers = {
				lsp = {
					fallbacks = {},
					-- score above buffer
					score_offset = 2,
				},
				buffer = {
					opts = {
						get_bufnrs = function()
							return vim.tbl_filter(function(bufnr)
								return vim.bo[bufnr].buftype == ""
							end, vim.api.nvim_list_bufs())
						end,
					},
				},
			},
		},
		cmdline = {
			completion = { menu = { auto_show = true } },
		},
		snippets = { preset = "luasnip" },
		completion = {
			menu = {
				border = "none",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "none",
				},
			},
		},
	},
}
