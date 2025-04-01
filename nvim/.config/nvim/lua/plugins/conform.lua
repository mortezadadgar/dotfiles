return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup {
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
			format_on_save = function()
				-- Stop if we disabled auto-formatting.
				if not vim.g.autoformat then
					return nil
				end

				return { timeout_ms = 500, lsp_fallback = true }
			end,
		}
	end,
	init = function()
		-- Use conform for gq
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		-- Start auto-formatting by default (and disable with my ToggleFormat command).
		vim.g.autoformat = true
	end,
}
