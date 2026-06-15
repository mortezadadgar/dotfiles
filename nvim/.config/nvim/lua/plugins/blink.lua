vim.pack.add {
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range "*" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
}

local source_priority = {
	lsp = 3,
	path = 2,
	buffer = 1,
	-- snippets = 1,
}

require("blink.cmp").setup {
	keymap = { preset = "enter" },
	snippets = { preset = "default" },
	sources = {
		default = {
			"lsp",
			-- "snippets",
			"buffer",
			"path",
		},
		providers = {
			lsp = { fallbacks = {} },
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
	fuzzy = {
		sorts = {
			-- https://github.com/saghen/blink.cmp/issues/1098#issuecomment-2679295335
			function(a, b)
				local a_priority = source_priority[a.source_id]
				local b_priority = source_priority[b.source_id]
				if a_priority ~= b_priority then
					return a_priority > b_priority
				end
			end,
			-- defaults
			"score",
			"sort_text",
		},
	},
	signature = { enabled = true },
	cmdline = { enabled = false },
	completion = {
		ghost_text = {
			enabled = false,
		},
		menu = {
			border = "none",
		},
		documentation = {
			auto_show = true,
		},
	},
}
