return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lsp = vim.lsp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

		local settings = {
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

		local servers = {
			"lua_ls",
			"gopls",
			"clangd",
			"bashls",
			"jsonls",
			"svelte",
			"emmet_language_server",
			"html",
			"cssls",
			"eslint",
		}

		for _, server in pairs(servers) do
			require("lspconfig")[server].setup {
				capabilities = capabilities,
				settings = settings[server],
			}
		end
	end,
}
