return {
	"neovim/nvim-lspconfig",
	config = function()
		local lsp = vim.lsp
		local capabilities = vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), {
			workspace = {
				didChangeWatchedFiles = { dynamicRegistration = true },
			},
		})

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
				vim.keymap.set({ "x", "n" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
			end,
		})

		local settings = {
			gopls = {
				gopls = {
					codelenses = {
						gc_details = true,
						test = true,
					},
					usePlaceholders = true,
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
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
			rust_analyzer = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
						extraArgs = { "--", "-Wclippy::pedantic" },
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
			tsserver = {
				implicitProjectConfiguration = {
					checkJs = true,
				},
			},
		}

		local init_options = {
			typos_lsp = {
				diagnosticSeverity = "Hint",
			},
		}

		local servers = {
			"lua_ls",
			"gopls",
			"templ",
			"bashls",
			"jsonls",
			"svelte",
			"html",
			"cssls",
			"eslint",
			"pyright",
			"tailwindcss",
			"tsserver",
			"typos_lsp",
			"rust_analyzer",
		}

		require("lspconfig")["clangd"].setup {
			capabilities = capabilities,
			cmd = { "clangd", "--offset-encoding=utf-16" },
		}

		for _, server in pairs(servers) do
			require("lspconfig")[server].setup {
				capabilities = capabilities,
				settings = settings[server],
				init_options = init_options[server],
			}
		end
	end,
}
