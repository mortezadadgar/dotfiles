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
			vim.cmd.colorscheme "onedark-nvim"
		end,
	},

	-- -- Completion engine
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	config = function()
	-- 		require "plugins.configs.nvim-cmp"
	-- 	end,
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 		"dcampos/nvim-snippy",
	-- 	},
	-- },

	-- Language server configs
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
				event = "LspAttach",
				opts = {},
			},
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require "plugins.configs.lspconfig"
		end,
	},

	-- Better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "nvim-treesitter/nvim-treesitter-context", opts = {} },
		},
		config = function()
			require "plugins.configs.treesitter"
		end,
		build = ":TSUpdate",
	},

	-- Snippets
	{
		"dcampos/nvim-snippy",
		config = function()
			require "plugins.configs.nvim-snippy"
		end,
	},

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
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

	-- Surrounding
	{
		"echasnovski/mini.surround",
		config = function()
			require "plugins.configs.mini-surround"
		end,
	},

	-- Comment lines
	{
		"echasnovski/mini.comment",
		config = function()
			require "plugins.configs.mini-comment"
		end,
	},

	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	-- Split and join arguments
	{ "echasnovski/mini.splitjoin", opts = {} },

	-- Undotree
	{ "mbbill/undotree" },
}
