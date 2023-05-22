local lsp = vim.lsp
local lspconfig = require "lspconfig"

-- enable lsp capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- custom attach
local on_attach = function(client, bufnr)
	local map = function(mode, keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
	end

	-- mappings
	map("n", "gr", function()
		lsp.buf.references { includeDeclaration = false }
	end, "List References")
	map("n", "gd", vim.lsp.buf.definition, "Goto definition")
	map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
	map("n", "<Space>rn", vim.lsp.buf.rename, "Rename")
	map("n", "<Space>d", vim.diagnostic.setloclist, "List Diagnostics")
	map("n", "<Space>ca", vim.lsp.buf.code_action, "Code action")
	map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- diagnostics symbols
	local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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

	-- disable lsp formatting
	client.server_capabilities.documentFormattingProvider = false

	-- format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "<buffer>",
		callback = function()
			vim.lsp.buf.format()
		end,
	})
end

-- setup mason so it can manage external tooling
require("mason").setup()
require("mason-lspconfig").setup()

local servers = {
	gopls = {
		gopls = {
			analyses = {
				unusedparams = true,
				nilness = true,
				unusedwrite = true,
				unusedvariable = true,
				useany = true,
			},
			staticcheck = true,
		},
	},
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

-- config installed lsp servers
require("mason-lspconfig").setup_handlers {
	function(server_name)
		lspconfig[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = servers[server_name],
		}
	end,
}
