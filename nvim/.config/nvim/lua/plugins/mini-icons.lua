return {
	"echasnovski/mini.icons",
	config = function()
		local minicons = require "mini.icons"
		minicons.setup()
		minicons.mock_nvim_web_devicons()
		minicons.tweak_lsp_kind()
	end,
}
