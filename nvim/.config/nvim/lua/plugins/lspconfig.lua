return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config {
			virtual_lines = {
				source = "if_many",
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

				local ok, fzf = pcall(require, "fzf-lua")
				if ok then
					vim.keymap.set("n", "grq", fzf.lsp_document_diagnostics, opts)
					vim.keymap.set("n", "gO", fzf.lsp_document_symbols, opts)
					vim.keymap.set("n", "grr", fzf.lsp_references, opts)
				end
			end,
		})

		local servers = {
			gopls = {
				settings = {
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
			},
			lua_ls = {
				settings = {
					Lua = {
						telemetry = {
							enable = false,
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
							},
						},
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
							extraArgs = { "--", "-Wclippy::pedantic" },
						},
					},
				},
			},
			vtsls = {
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
			},
			svelte = {
				settings = {
					svelte = {
						plugin = {
							html = { completions = { emmet = false } },
							css = { completions = { emmet = false } },
						},
					},
				},
			},
			-- ts_ls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			jsonls = {},
			eslint = {},
			pyright = {},
			clangd = {},
			typos_lsp = {},
			bashls = {},
		}

		-- enable file watching capabilities
		local capabilities = require("blink.cmp").get_lsp_capabilities {
			workspace = {
				didChangeWatchedFiles = { dynamicRegistration = true },
			},
		}

		for server, config in pairs(servers) do
			require("lspconfig")[server].setup {
				capabilities = capabilities,
				settings = config.settings,
			}
		end
	end,
}
