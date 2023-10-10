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
		["<C-n>"] = map.select_next_item(),
		["<C-p>"] = map.select_prev_item(),

		["<Tab>"] = map(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end),

		["<S-Tab>"] = map(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end),
	},

	sources = {
		{ name = "nvim_lsp", max_item_count = 200 },
		{ name = "path" },
		{ name = "luasnip" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
	},

	formatting = {
		format = function(_, vim_item)
			vim_item.abbr = string.sub(vim_item.abbr, 1, 45)
			return vim_item
		end,
	},

	window = {
		completion = {
			scrollbar = false,
		},
	},
}
