return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local lsp = vim.lsp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
			border = "single",
		})
		lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
			border = "single",
		})

		vim.diagnostic.config {
			virtual_text = {
				source = "if_many",
			},
			float = {
				border = "single",
			},
			severity_sort = true,
		}

		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local t = require "telescope.builtin"

				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gr", t.lsp_references, opts)
				vim.keymap.set("n", "gd", t.lsp_definitions, opts)
				vim.keymap.set("n", "gI", t.lsp_implementations, opts)
				vim.keymap.set("n", "<space>sy", t.lsp_document_symbols, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<space>d", t.diagnostics, opts)
				vim.keymap.set({ "x", "n" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

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

		require("neodev").setup()
		require("mason").setup()
		require("mason-lspconfig").setup()

		require("mason-lspconfig").setup_handlers {
			function(server_name)
				require("lspconfig")[server_name].setup {
					capabilities = capabilities,
					settings = servers[server_name],
				}
			end,
		}
	end,
}
