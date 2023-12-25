return {
	"stevearc/conform.nvim",
	event = { "LspAttach", "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			yaml = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			go = { "goimports" },
		},
		formatters = {
			prettierd = {
				prepend_args = { "--use-tabs" },
			},
		},
		format_on_save = function(bufnr)
			local ignore_filetypes = { "c", "cpp" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
