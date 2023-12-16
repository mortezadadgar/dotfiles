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

-- restore last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function()
		-- make sure the last cursor position is valid
		local line = vim.fn.line "'\""
		if line < 1 and line > vim.fn.line "$" then
			return
		end

		-- exclude for selected filetypes
		local exclude = { "gitcommit", "gitrebase" }
		if vim.tbl_contains(exclude, vim.bo.ft) then
			return
		end

		vim.cmd 'normal! g`"zz'
	end,
})
