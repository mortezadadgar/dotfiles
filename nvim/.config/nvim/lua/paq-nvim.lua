-- enable fast loader
vim.loader.enable()

require "paq" {
	"savq/paq-nvim",
	"mortezadadgar/onedark-nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-commentary",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"NvChad/nvim-colorizer.lua",
	"mbbill/undotree",
	"stevearc/conform.nvim",
	"echasnovski/mini.completion",
	"dcampos/nvim-snippy",
}

-- colorscheme
vim.cmd.colorscheme "onedark.nvim"

-- load configs
require "plugins"
