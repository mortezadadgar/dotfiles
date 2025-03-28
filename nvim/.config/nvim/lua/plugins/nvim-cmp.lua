return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"ray-x/cmp-treesitter",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require "cmp"
		local map = cmp.mapping

		require("cmp").setup {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-e>"] = map.close(),
				["<C-b>"] = map.scroll_docs(-4),
				["<C-f>"] = map.scroll_docs(4),
				["<C-n>"] = map.select_next_item(),
				["<C-p>"] = map.select_prev_item(),
				["<Tab>"] = map.select_next_item(),
				["<S-Tab>"] = map.select_prev_item(),

				["<CR>"] = cmp.mapping {
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm { select = true },
				},
			},
			sources = {
				{ name = "nvim_lsp", priority = 100 },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "treesitter" },
				{
					name = "buffer",
					keyword_length = 2,
					priority = 1,
					option = {
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end,
					},
				},
			},
			formatting = {
				format = require("lspkind").cmp_format {
					mode = "symbol_text",
					maxwidth = {
						menu = 50,
						abbr = 50,
					},
				},
			},
			preselect = cmp.PreselectMode.None,
		}
	end,
}
