local cmp = require "cmp"
local ls = require "luasnip"
local compare = require "cmp.config.compare"
local map = cmp.mapping

cmp.setup {
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-e>"] = map.close(),
		["<CR>"] = map.confirm { select = false },
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expand_or_locally_jumpable() then
				ls.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.locally_jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	sources = {
		{ name = "nvim_lsp" },
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

	formatting = {
		format = require("lspkind").cmp_format {
			mode = "text",
			with_text = true,
		},
	},
}
