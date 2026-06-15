vim.pack.add {
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
}

vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "BlinkCmpDocBorder" })
vim.cmd.colorscheme "rose-pine"
