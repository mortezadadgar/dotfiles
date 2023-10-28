-- enable fast loader
vim.loader.enable()

require "paq" {
	"savq/paq-nvim",
	"mortezadadgar/onedark-nvim",
	"neovim/nvim-lspconfig",
	"folke/neodev.nvim",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-context",
	"RRethy/nvim-treesitter-textsubjects",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"echasnovski/mini.hipatterns",
	"echasnovski/mini.splitjoin",
	"stevearc/oil.nvim",
	"mbbill/undotree",
	"stevearc/conform.nvim",
}

-- colorscheme
vim.cmd.colorscheme "onedark.nvim"

-- load configs
require "plugins"
