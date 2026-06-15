vim.pack.add {
	{ src = "https://github.com/neovim/nvim-lspconfig" },
}

vim.lsp.enable {
	"gopls",
	"lua_ls",
	"ts_ls",
	"eslint",
	-- "vtsls",
	"zls",
	"svelte",
	"html",
	"cssls",
	"jsonls",
	"yamlls",
	"tailwindcss",
	"typos_lsp",
	"pyright",
}

local js_settings = {
	updateImportsOnFileMove = "always",
	-- suggest = {
	-- 	completeFunctionCalls = true,
	-- },
	tsserver = {
		maxTsServerMemory = 8192,
	},
}

-- local capabilities = {
-- 	workspace = {
-- 		-- install inotify-tools
-- 		didChangeWatchedFiles = {
-- 			dynamicRegistration = true,
-- 		},
-- 	},
-- }
-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("svelte", {
	cmd = {
		"node",
		"--max-old-space-size=8192",
		vim.fn.exepath "svelteserver",
		"--stdio",
	},
})

vim.lsp.config("pyright", {
	handlers = {
		["$/progress"] = function() end,
	},
})

vim.lsp.config("vtsls", {
	settings = {
		typescript = js_settings,
		javascript = js_settings,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
	},
})

vim.diagnostic.config {
	virtual_text = {
		source = "if_many",
	},
	severity_sort = true,
	status = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float {
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			}
		end,
	},
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttachGroup", {}),
	callback = function(args)
		vim.keymap.set("n", "grq", "<cmd>FzfLua diagnostics_document<cr>", { buffer = args.buf, desc = "Diagnostic buffer" })
		vim.keymap.set("n", "grQ", "<cmd>FzfLua diagnostics_workspace<cr>", { buffer = args.buf, desc = "Diagnostic workspace" })
		vim.keymap.set("n", "gO", "<cmd>FzfLua lsp_document_symbols<cr>", { buffer = args.buf, desc = "Symbols document" })
		vim.keymap.set("n", "grr", "<cmd>FzfLua lsp_references<cr>", { buffer = args.buf, desc = "LSP References" })
		vim.keymap.set("n", "gri", "<cmd>FzfLua lsp_implementations<cr>", { buffer = args.buf, desc = "LSP Implementation" })

		-- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		-- if client:supports_method "textDocument/codeLens" then
		-- 	vim.lsp.codelens.enable(true)
		-- end

		-- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Enable auto-completion
		-- if client:supports_method "textDocument/completion" then
		-- 	vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		-- end
	end,
})
