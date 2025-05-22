return {
	"rose-pine/neovim",
	version = "*",
	name = "rose-pine",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "rose-pine"
		vim.api.nvim_set_hl(0, "StatusLineTerm", { link = "StatusLine" })
		vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1F1D2E" })
		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#6e6a86", bg = "#1F1D2E" })
		vim.api.nvim_set_hl(0, "MiniCompletionInfoBorderOutdated", { link = "FloatBorder", force = true })
	end,
}
