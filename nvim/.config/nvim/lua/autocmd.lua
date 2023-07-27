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

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(event)
		if event.match:match "^%w%w+://" then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
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
