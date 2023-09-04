-- enable fast loader
vim.loader.enable()

require "paq" {
	"savq/paq-nvim",
	{ "mortezadadgar/onedark-nvim", run = vim.cmd.colorscheme "onedark.nvim" },
	"neovim/nvim-lspconfig",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"echasnovski/mini.splitjoin",
	"NvChad/nvim-colorizer.lua",
}

-- load configs
require "plugins"
