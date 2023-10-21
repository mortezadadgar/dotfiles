local lsp = vim.lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- custom attach
local on_attach = function(_, bufnr)
	local border = "single"
	local map = function(mode, keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
	end

	local t = require "telescope.builtin"

	-- mappings
	map("n", "gr", t.lsp_references, "List References")
	map("n", "gd", t.lsp_definitions, "Goto definition")
	map("n", "gI", t.lsp_implementations, "Goto definition")
	map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
	map("n", "<Space>rn", vim.lsp.buf.rename, "Rename")
	map("n", "<Space>d", t.diagnostics, "List Diagnostics")
	map({ "v", "n" }, "<Space>ca", vim.lsp.buf.code_action, "Code action")
	map("n", "<Space>cl", vim.lsp.codelens.run, "Code lens")
	map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	map("n", "<Space>e", vim.diagnostic.open_float, "Diagnostic float")
	map("n", "[d", vim.diagnostic.goto_prev, "Next diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

	-- diagnostics symbols
	local signs = { Error = "", Warn = "", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl })
	end

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

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat", {}),
		callback = function()
			local disabled_formatter = { "cssls", "html", "lua_ls", "clangd" }
			vim.lsp.buf.format {
				filter = function(c)
					return not vim.tbl_contains(disabled_formatter, c.name)
				end,
			}
		end,
	})
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
			diagnostics = {
				globals = { "vim" },
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
