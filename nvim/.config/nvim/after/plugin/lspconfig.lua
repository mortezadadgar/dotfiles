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
	callback = function(ev)
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "x", "n" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts)
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		local fzf = require "fzf-lua"
		vim.keymap.set("n", "gd", fzf.lsp_definitions, opts)
		vim.keymap.set("n", "gr", fzf.lsp_references, opts)
		vim.keymap.set("n", "gI", fzf.lsp_implementations, opts)
		vim.keymap.set("n", "<space>q", fzf.lsp_document_diagnostics, opts)
		vim.keymap.set("n", "<space>sy", fzf.lsp_document_symbols, opts)
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
	"ts_ls",
	"typos_lsp",
	"rust_analyzer",
	"hls",
	"clangd",
}

for _, server in pairs(servers) do
	require("lspconfig")[server].setup {
		capabilities = capabilities,
		settings = settings[server],
		init_options = init_options[server],
	}
end
