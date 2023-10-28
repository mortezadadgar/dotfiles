local function augroup(name)
	return vim.api.nvim_create_augroup(name, {})
end

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup "highlightYank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disable auto formatting on newline
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup "autoCommentOff",
	callback = function()
		vim.opt.formatoptions:remove { "r", "o" }
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup "resizeSplits",
	callback = function()
		vim.cmd "tabdo wincmd ="
	end,
})

-- enable spell check and preferable textwidth in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup "textFt",
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 80
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup "lastLoc",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
