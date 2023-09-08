local cmp = require "cmp"
local map = cmp.mapping

cmp.setup {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-e>"] = map.close(),
		["<CR>"] = map.confirm { select = true },

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end),
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 2 },
	},

	formatting = {
		format = function(_, vim_item)
			vim_item.abbr = string.sub(vim_item.abbr, 1, 45)
			return vim_item
		end,
	},
}
