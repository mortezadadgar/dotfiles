return {
	"saghen/blink.cmp",
	dependencies = {
		"echasnovski/mini.snippets",
	},
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
				},
				buffer = {
					-- score below lsp
					score_offset = -5,
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
		snippets = { preset = "mini_snippets" },
		cmdline = { enabled = false },
		completion = {
			menu = { border = "none" },
			documentation = {
				auto_show = true,
			},
		},
	},
}
