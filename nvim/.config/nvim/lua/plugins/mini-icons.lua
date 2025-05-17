return {
	"echasnovski/mini.icons",
	config = function()
		local miniicons = require "mini.icons"
		miniicons.setup()
		miniicons.tweak_lsp_kind()
	end,
}
