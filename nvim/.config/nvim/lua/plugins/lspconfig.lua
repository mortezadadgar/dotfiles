return {
	"neovim/nvim-lspconfig",
	config = function()
		local lsp = vim.lsp

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
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				local opts = { buffer = args.buf }
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				if client == nil then
					return
				end

				if client.name == "svelte" then
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile",
							{ clear = true }),
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end

				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "grl", vim.lsp.codelens.run, opts)
				vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				local ok, fzf = pcall(require, "fzf-lua")
				if ok then
					vim.keymap.set("n", "gd", fzf.lsp_definitions, opts)
					vim.keymap.set("n", "grr", fzf.lsp_references, opts)
					vim.keymap.set("n", "gri", fzf.lsp_implementations, opts)
					vim.keymap.set("n", "<space>q", fzf.lsp_document_diagnostics, opts)
					vim.keymap.set("n", "gO", fzf.lsp_document_symbols, opts)
					vim.keymap.set({ "x", "n" }, "gra", fzf.lsp_code_actions, opts)
				end
			end,
		})

		local settings = {
			gopls = {
				gopls = {
					codelenses = {
						gc_details = true,
						test = true,
					},
					-- usePlaceholders = true,
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
						library = {
							"${3rd}/luv/library",
							---@diagnostic disable-next-line: deprecated
							unpack(vim.api.nvim_get_runtime_file("", true)),
						},
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
			jsonls = {
				json = {
					validate = { enable = true },
				},
			},
			ts_ls = {
				-- enable checking javascript without a `jsconfig.json`
				implicitProjectConfiguration = { checkJs = true },
			}
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
			-- "ts_ls",
			"typos_lsp",
			"rust_analyzer",
			"hls",
			"clangd",
		}

		require("lspconfig.configs").vtsls = require("vtsls").lspconfig
		require("lspconfig").vtsls.setup({
			settings = {
				vtsls = {
					autoUseWorkspaceTsdk = true,
					experimental = {
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
				},
			},
		})

		for _, server in pairs(servers) do
			require("lspconfig")[server].setup {
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
				settings = settings[server],
				init_options = init_options[server],
			}
		end
	end,
}
