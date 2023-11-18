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
	"j-hui/fidget.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-lua/plenary.nvim",
	"lewis6991/gitsigns.nvim",
	"NeogitOrg/neogit",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"stevearc/conform.nvim",
	"luukvbaal/nnn.nvim",
}

-- colorscheme
vim.cmd.colorscheme "onedark.nvim"

-- load configs
require "plugins"
