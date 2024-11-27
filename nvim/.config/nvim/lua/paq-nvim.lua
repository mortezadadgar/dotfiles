-- enable fast loader
vim.loader.enable()

require "paq" {
	-- Appearance
	"rose-pine/neovim",

	-- LSP, completion, formatting
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"stevearc/conform.nvim",

	-- TreeSitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- fuzzy finder
	"ibhagwan/fzf-lua",

	-- Git
	"tpope/vim-fugitive",

	-- file explorer
	"echasnovski/mini.files",

	-- Misc
	"nvim-tree/nvim-web-devicons",
	"echasnovski/mini.hipatterns",
}

-- colorscheme
vim.cmd.colorscheme "rose-pine"
