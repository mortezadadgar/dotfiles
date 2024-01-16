return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("TSImports", {}),
			pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
			callback = function()
				vim.cmd "TSToolsAddMissingImports sync"
				vim.cmd "TSToolsRemoveUnusedImports sync"
			end,
		})
	end,
	config = true,
}
