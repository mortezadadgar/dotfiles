return {
	"rose-pine/neovim",
	version = "*",
	name = "rose-pine",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "rose-pine"
		vim.api.nvim_set_hl(0, "StatusLineTerm", { link = "StatusLine" })
	end,
}
