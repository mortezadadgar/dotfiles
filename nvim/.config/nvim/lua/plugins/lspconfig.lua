local lsp = vim.lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- custom attach
local on_attach = function(client, bufnr)
	local map = function(mode, keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
	end

	-- local t = require "telescope.builtin"

	-- mappings
	map("n", "gr", vim.lsp.buf.references, "List References")
	map("n", "gd", vim.lsp.buf.definition, "Goto definition")
	map("n", "gI", vim.lsp.buf.implementation, "Goto definition")
	map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
	map("n", "<Space>rn", vim.lsp.buf.rename, "Rename")
	map("n", "<Space>d", vim.diagnostic.setqflist, "List Diagnostics")
	map({ "v", "n" }, "<Space>ca", vim.lsp.buf.code_action, "Code action")
	map("n", "<Space>cl", vim.lsp.codelens.run, "Code lens")
	map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	map("n", "<Space>e", vim.diagnostic.open_float, "Diagnostic float")
	map("n", "[d", vim.diagnostic.goto_prev, "Next diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
	map("n", "<C-w>d", ":split | Telescope lsp_definitions<CR>")

	-- diagnostics symbols
	local signs = { Error = "", Warn = "", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl })
	end

	-- floating window border
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

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "<buffer>",
		callback = function()
			local disabled_formatter = { "cssls", "html", "lua_ls", "clangd" }
			vim.lsp.buf.format {
				filter = function(client_format)
					return not vim.tbl_contains(disabled_formatter, client_format.name)
				end,
			}
		end,
	})

	if client.supports_method "textDocument/codeLens" then
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			pattern = "<buffer>",
			callback = function()
				vim.lsp.codelens.refresh()
			end,
		})
	end
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
			workspace = {
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

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
