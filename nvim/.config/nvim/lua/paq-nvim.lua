-- enable fast loader
vim.loader.enable()

require "paq" {
	"savq/paq-nvim",
	"mortezadadgar/onedark-nvim",
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
	{ "j-hui/fidget.nvim", branch = "legacy" },
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"echasnovski/mini.comment",
	"echasnovski/mini.hipatterns",
	"echasnovski/mini.surround",
	"stevearc/oil.nvim",
	"mbbill/undotree",
	"stevearc/conform.nvim",
}

-- colorscheme
vim.cmd.colorscheme "onedark.nvim"

-- load configs
require "plugins"
