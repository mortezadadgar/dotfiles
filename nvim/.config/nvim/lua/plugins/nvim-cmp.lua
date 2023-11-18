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
		["<CR>"] = map.confirm { select = false },
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
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
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

	formatting = {
		format = function(_, vim_item)
			vim_item.abbr = string.sub(vim_item.abbr, 1, 45)
			return vim_item
		end,
	},

	-- do not trigger completion on space
	completion = {
		get_trigger_characters = function(chars)
			local new_chars = {}
			for _, char in ipairs(chars) do
				if char ~= " " then
					table.insert(new_chars, char)
				end
			end
			return new_chars
		end,
	},
}
