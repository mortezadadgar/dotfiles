local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print "Installing Lazy.nvim..."
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
	-- Colorscheme
	{
		"mortezadadgar/onedark-nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme "onedark.nvim"
		end,
	},

	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		config = function()
			require "plugins.configs.nvim-cmp"
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	-- Language server configs
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},
		config = function()
			require "plugins.configs.lspconfig"
		end,
	},

	-- Better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 2 } },
		},
		config = function()
			require "plugins.configs.treesitter"
		end,
	},

	{
		"dcampos/nvim-snippy",
		enabled = false,
		dependencies = {
			"smjonas/snippet-converter.nvim",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require "plugins.configs.nvim-snippy"
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		enabled = false,
		keys = { "<C-l>", "<C-h>" },
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require "plugins.configs.luasnip"
		end,
	},

	-- Colorizer
	{
		"NvChad/nvim-colorizer.lua",
		ft = { "css", "html" },
		config = function()
			require("colorizer").setup {
				css = { css = true },
			}
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require "plugins.configs.telescope"
		end,
	},

	-- GitSigns
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require "plugins.configs.gitsigns"
		end,
	},

	-- Which key
	{
		"folke/which-key.nvim",
		enabled = false,
		init = function()
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},

	-- Split and join arguments
	{
		"Wansmer/treesj",
		keys = { "gS" },
		config = function()
			require "plugins.configs.treesj"
		end,
	},

	-- Comment lines
	{
		"numToStr/Comment.nvim",
		config = function()
			require "plugins.configs.comment-nvim"
		end,
	},

	-- Surrounding
	{ "kylechui/nvim-surround", opts = {} },
}
