local template = {
	sources = {
		vscode = {
			"./friendly-snippets/snippets/",
		},
	},
	output = {
		snipmate = {
			vim.fn.stdpath "data" .. "/site/snippets",
		},
	},
}

require("snippet_converter").setup {
	templates = { template },
}

local snippy = require "snippy"

vim.api.nvim_create_autocmd("CompleteDone", {
	group = vim.api.nvim_create_augroup("snippy", { clear = true }),
	callback = function()
		snippy.complete_done()
	end,
})

snippy.setup {
	mappings = {
		is = {
			["<C-l>"] = "next",
			["<C-h>"] = "previous",
		},
	},
}
