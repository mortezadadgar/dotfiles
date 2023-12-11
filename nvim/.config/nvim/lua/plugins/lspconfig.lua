return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lsp = vim.lsp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(_, bufnr)
			local border = "single"
			local map = function(mode, keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
			end

			-- mappings
			map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
			map("n", "<space>rn", vim.lsp.buf.rename, "Rename")
			map({ "x", "n" }, "<space>ca", vim.lsp.buf.code_action, "Code action")
			map("n", "<space>cl", vim.lsp.codelens.run, "Code lens")
			map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			map("n", "<space>e", vim.diagnostic.open_float, "Diagnostic float")
			map("n", "[d", vim.diagnostic.goto_prev, "Next diagnostic")
			map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

			-- floating window border
			lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
				border = border,
			})
			lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
				border = border,
			})

			vim.diagnostic.config {
				virtual_text = {
					source = "if_many",
				},
				float = {
					border = border,
				},
				severity_sort = true,
			}
		end

		local servers = {
			gopls = {
				gopls = {
					codelenses = {
						gc_details = true,
						test = true,
					},
					analyses = {
						unusedparams = true,
						nilness = true,
						unusedwrite = true,
						unusedvariable = true,
						useany = true,
					},
					gofumpt = true,
					staticcheck = true,
				},
			},
			lua_ls = {
				Lua = {
					telemetry = {
						enable = false,
					},
				},
			},
			svelte = {
				svelte = {
					plugin = {
						html = { completions = { emmet = false } },
						css = { completions = { emmet = false } },
					},
				},
			},
		}

		require("neodev").setup {}

		-- setup mason so it can manage external tooling
		require("mason").setup()
		require("mason-lspconfig").setup()

		-- config installed lsp servers
		require("mason-lspconfig").setup_handlers {
			function(server_name)
				require("lspconfig")[server_name].setup {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = servers[server_name],
				}
			end,
		}
	end,
}
