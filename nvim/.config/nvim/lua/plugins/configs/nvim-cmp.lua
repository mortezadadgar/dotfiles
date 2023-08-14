local cmp = require "cmp"
local compare = require "cmp.config.compare"
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
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},

	sorting = {
		comparators = {
			-- compare.sort_text,
			compare.offset,
			compare.exact,
			compare.score,
			-- compare.recently_used,
			-- compare.locality,
			compare.kind,
			compare.length,
			compare.order,
		},
	},
}
