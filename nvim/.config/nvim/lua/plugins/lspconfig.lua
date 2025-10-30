return {
	"neovim/nvim-lspconfig",
	version = "*",
	config = function()
		vim.diagnostic.config {
			virtual_text = {
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
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				if client == nil then
					return
				end

				vim.keymap.set(
					"n",
					"grq",
					vim.diagnostic.setqflist,
					{ buffer = args.buf, desc = "LSP: document diagnostics" }
				)
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
			svelte = {},
			ts_ls = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			jsonls = {},
			eslint = {},
			pyright = {},
			clangd = {
				cmd = { "clangd", "--log=error", "--function-arg-placeholders=false" },
			},
			typos_lsp = {},
			bashls = {},
			marksman = {},
			templ = {},
		}

		-- enable file watching capabilities
		local capabilities = require("blink.cmp").get_lsp_capabilities {
			workspace = {
				didChangeWatchedFiles = { dynamicRegistration = true },
			},
		}

		vim.lsp.config("*", { capabilities = capabilities })

		for server, settings in pairs(servers) do
			vim.lsp.enable(server)
			vim.lsp.config(server, settings)
		end
	end,
}
