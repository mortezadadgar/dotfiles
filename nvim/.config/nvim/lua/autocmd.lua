local group = vim.api.nvim_create_augroup("UserAutocmd", { clear = true })

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disables automatic commenting on newline
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	group = group,
	command = "setlocal fo-=c fo-=r fo-=o",
})

-- treat go's templates as html files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.tmpl",
	group = group,
	command = "setlocal ft=html",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	group = group,
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- formatting
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.html", "*.css" },
	group = group,
	callback = function()
		local ft = vim.fn.expand "%:e"
		local saved_cursor = vim.fn.getcurpos()
		if ft == "html" or ft == "css" then
			vim.cmd "silent :%!prettierd --stdin-filepath %"
		elseif ft == "lua" then
			vim.cmd "silent :%!stylua -s --stdin-filepath % -"
		end
		vim.fn.setpos(".", saved_cursor)
	end,
})
