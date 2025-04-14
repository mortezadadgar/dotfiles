return {
	"echasnovski/mini.icons",
	lazy = true,
	config = function()
		local minicons = require "mini.icons"
		minicons.setup()
		minicons.tweak_lsp_kind()
	end,
}
