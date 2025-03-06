return {
	"stevearc/conform.nvim",
	config = function()
		require('conform').setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				yaml = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				go = { "goimports" },
				templ = { "templ" },
			},
			notify_on_error = false,
			format_on_save = function(bufnr)
				local ignore_filetypes = { "c", "cpp" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
			init = function()
				-- Use conform for gq
				vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			end
		})
	end
}
