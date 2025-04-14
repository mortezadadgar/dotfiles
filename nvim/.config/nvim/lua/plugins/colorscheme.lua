return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "rose-pine"
		vim.api.nvim_set_hl(0, "StatusLineTerm", { link = "StatusLine" })
		vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1F1D2E" })
		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#6e6a86", bg = "#1F1D2E" })
		-- vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { fg = "#e0def4", bg = "#191724" })
	end,
}
