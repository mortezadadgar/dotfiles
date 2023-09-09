-- enable fast loader
vim.loader.enable()

require "paq" {
	{ "mortezadadgar/onedark-nvim", run = vim.cmd.colorscheme "onedark.nvim" },
	"neovim/nvim-lspconfig",
	"mhartington/formatter.nvim",
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
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"echasnovski/mini.splitjoin",
}

-- load configs
require "plugins"
