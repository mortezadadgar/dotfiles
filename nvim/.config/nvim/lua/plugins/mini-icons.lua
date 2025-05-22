return {
	"echasnovski/mini.icons",
	version = "*",
	config = function()
		local miniicons = require "mini.icons"
		miniicons.setup()
		miniicons.tweak_lsp_kind()
	end,
}
