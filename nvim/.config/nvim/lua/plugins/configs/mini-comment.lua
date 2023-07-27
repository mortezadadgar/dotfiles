require("mini.comment").setup {
	options = {
		custom_commentstring = function()
			return vim.bo.commentstring
		end,
		ignore_blank_line = true,
	},
}
