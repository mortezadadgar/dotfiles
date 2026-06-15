vim.pack.add {
	{ src = "https://github.com/stevearc/conform.nvim" },
}

require("conform").setup {
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		svelte = { "prettierd" },
		typescript = { "prettierd" },
		yaml = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		go = { "goimports" },
		templ = { "templ" },
	},
	formatters = {
		-- Require a prettierd configuration file to format.
		prettierd = {
			require_cwd = true,
		},
	},
	format_on_save = function()
		-- Stop if we disabled auto-formatting.
		if not vim.g.autoformat then
			return nil
		end

		return { timeout_ms = 1000, lsp_format = "fallback" }
	end,
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.g.autoformat = true

vim.api.nvim_create_user_command("ToggleFormat", function()
	vim.g.autoformat = not vim.g.autoformat
	vim.notify(string.format("%s formatting", vim.g.autoformat and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Toggle conform.nvim auto-formatting", nargs = 0 })
