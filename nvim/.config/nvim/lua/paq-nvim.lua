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
	"j-hui/fidget.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-lua/plenary.nvim",
	"lewis6991/gitsigns.nvim",
	"nvim-tree/nvim-web-devicons",
	"kylechui/nvim-surround",
	"echasnovski/mini.comment",
	"echasnovski/mini.pairs",
	"echasnovski/mini.splitjoin",
	"echasnovski/mini.hipatterns",
	"stevearc/oil.nvim",
	"stevearc/conform.nvim",
}

-- colorscheme
vim.cmd.colorscheme "onedark.nvim"

-- load configs
require "plugins"
