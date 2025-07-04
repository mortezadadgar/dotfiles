return {
	"echasnovski/mini.snippets",
	version = "*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local minisnippets = require "mini.snippets"
		minisnippets.setup {
			snippets = {
				-- load friendly snippets
				minisnippets.gen_loader.from_lang(),
			},
		}
		minisnippets.start_lsp_server()
	end,
}
