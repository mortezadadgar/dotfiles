local create_autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disables automatic commenting on newline
create_autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal fo-=c fo-=r fo-=o",
})

-- treat go's templates as html files
create_autocmd("BufEnter", {
	pattern = "*.tmpl",
	command = "set ft=html",
})

-- workaround colorizer bug
create_autocmd("TextChanged", {
	pattern = "*.css",
	command = "ColorizerAttachToBuffer",
})

create_autocmd("QuickFixCmdPost", {
	pattern = "[^l]*",
	command = "cwindow",
})
