return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			keys = {
				{
					"<C-l>",
					mode = { "i", "s" },
					function()
						require("luasnip").jump(1)
					end,
				},
				{
					"<C-j>",
					mode = { "i", "s" },
					function()
						require("luasnip").jump(-1)
					end,
				},
			},
			lazy = false,
			opts = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip").filetype_extend("svelte", { "html", "css" })
				return {
					history = true,
				}
			end,
		},
	},
	opts = function()
		local cmp = require "cmp"
		local map = cmp.mapping

		return {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			mapping = {
				["<C-e>"] = map.close(),
				["<CR>"] = map.confirm(),
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
				{ name = "emoji" },
			},

			formatting = {
				format = require("lspkind").cmp_format {
					maxwidth = 50,
				},
			},
		}
	end,
}
