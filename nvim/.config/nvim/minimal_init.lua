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
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},

		config = function()
			local on_attach = function(_, bufnr)
				local map = function(mode, keys, func, desc)
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
				end
				local t = require "telescope.builtin"
				map("n", "gr", t.lsp_references, "List References")
				map("n", "gd", t.lsp_definitions, "Goto definition")
				map("n", "gI", t.lsp_implementations, "Goto definition")
			end
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers {
				function(server_name)
					require("lspconfig")[server_name].setup {
						on_attach = on_attach,
					}
				end,
			}
		end,
	},

	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",
}

vim.o.clipboard = "unnamedplus"
