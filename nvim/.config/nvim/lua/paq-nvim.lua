-- enable fast loader
vim.loader.enable()

require "paq" {
	"savq/paq-nvim",
	{ "mortezadadgar/onedark-nvim", run = vim.cmd.colorscheme "onedark.nvim" },
	"neovim/nvim-lspconfig",
	"mhartington/formatter.nvim",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-tree/nvim-web-devicons",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"echasnovski/mini.splitjoin",
}

-- load configs
require "plugins"
