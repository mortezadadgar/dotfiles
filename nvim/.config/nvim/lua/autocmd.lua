-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disables automatic commenting on newline
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "setlocal fo-=c fo-=r fo-=o",
})

-- treat go's templates as html files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.tmpl",
	command = "set ft=html",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
