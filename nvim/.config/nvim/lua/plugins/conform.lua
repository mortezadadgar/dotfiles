require("conform").setup {
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
}
