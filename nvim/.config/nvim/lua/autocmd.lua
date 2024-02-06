local group = vim.api.nvim_create_augroup("UserGroup", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disable auto formatting on newline",
	group = group,
	callback = function()
		vim.opt.formatoptions:remove { "r", "o" }
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	desc = "Resize splits if window got resized",
	group = group,
	command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	desc = "Show quickfix window automatically",
	group = group,
	pattern = "[^l]*",
	command = "cwindow",
	nested = true,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Go to last loc when opening a buffer",
	group = group,
	callback = function(event)
		local buf = event.buf
		local exclude = { "gitcommit", "gitrebase" }
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
