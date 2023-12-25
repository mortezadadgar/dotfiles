return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		"neovim/nvim-lspconfig",
	},
	event = { "BufReadPre *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
	config = true,
}
