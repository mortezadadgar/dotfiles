return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				local ls = require "luasnip"

				vim.keymap.set({ "i", "s" }, "<C-l>", function()
					ls.jump(1)
				end)
				vim.keymap.set({ "i", "s" }, "<C-h>", function()
					ls.jump(-1)
				end)

				require("luasnip.loaders.from_vscode").lazy_load()
				ls.filetype_extend("svelte", { "html", "css" })
			end,
		},
	},
	config = function()
		local cmp = require "cmp"
		local map = cmp.mapping
		local ls = require("luasnip")

		require("cmp").setup {
			snippet = {
				expand = function(args)
					ls.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-e>"] = map.close(),
				["<C-n>"] = map.select_next_item(),
				["<C-p>"] = map.select_prev_item(),
				["<Tab>"] = map.select_next_item(),
				["<S-Tab>"] = map.select_prev_item(),

				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if ls.expandable() then
							ls.expand()
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),

			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
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
				format = require('lspkind').cmp_format({
					maxwidth = {
						menu = 50,
						abbr = 50,
					},
				})
			},
			completion = {
				completeopt = 'menu,menuone,noinsert'
			}
			-- preselect = cmp.PreselectMode.None,
		}
	end
}
