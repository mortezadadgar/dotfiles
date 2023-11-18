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

-- enable spell check and preferable textwidth in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 80
	end,
})

-- show quickfix window automatically
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = group,
	pattern = "[^l]*",
	command = "cwindow",
	nested = true,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
