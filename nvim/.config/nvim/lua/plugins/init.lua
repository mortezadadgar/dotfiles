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
	-- Comment lines
  { 'numToStr/Comment.nvim', opts = {} },

	-- Colorscheme
	{
		"mortezadadgar/onedark-nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme "onedark-nvim"
		end,
	},

	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require "plugins.configs.cmp"
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	-- Language server configs
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			require "plugins.configs.lspconfig"
		end,
	},

	-- Null language server
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require "plugins.configs.null_ls"
		end,
	},

	-- Better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require "plugins.configs.treesitter"
			pcall(require("nvim-treesitter.install").update())
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require "plugins.configs.luasnip"
		end,
	},

	-- Statusline
	{
		"feline-nvim/feline.nvim",
		config = function()
			require "plugins.configs.feline"
		end,
	},

	-- Auto close pairs
	{ "windwp/nvim-autopairs", opts = {} },

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
		dependencies = "nvim-lua/plenary.nvim",
		tag = "0.1.1",
		config = function()
			require "plugins.configs.telescope"
		end,
	},

	"kyazdani42/nvim-web-devicons",
}
