local group = vim.api.nvim_create_augroup("UserGroup", {})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disable auto formatting on newline
vim.api.nvim_create_autocmd("BufEnter", {
	group = group,
	callback = function()
		vim.opt.formatoptions:remove { "r", "o" }
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

-- show quickfix window automatically
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = group,
	pattern = "[^l]*",
	command = "cwindow",
	nested = true,
})
