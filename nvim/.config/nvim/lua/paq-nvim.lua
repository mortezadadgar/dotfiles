-- enable fast loader
vim.loader.enable()

require "paq" {
	{ "mortezadadgar/onedark-nvim", run = vim.cmd.colorscheme "onedark.nvim" },
	"neovim/nvim-lspconfig",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	{ "j-hui/fidget.nvim", branch = "legacy" },
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	{ "j-hui/fidget.nvim", branch = "legacy" },
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-commentary",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-surround",
	"stevearc/oil.nvim",
	"NvChad/nvim-colorizer.lua",
	"mbbill/undotree",
	"stevearc/conform.nvim",
}

-- load configs
require "plugins"
