require("lint").linters_by_ft = {
	c = { "clangtidy" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	pattern = "*.c",
	callback = function()
		require("lint").try_lint()
	end,
})
