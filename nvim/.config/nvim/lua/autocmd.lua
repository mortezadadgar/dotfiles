local function augroup(name)
	return vim.api.nvim_create_augroup(name, {})
end

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = augroup "highlightYank",
	callback = function()
		vim.highlight.on_yank()
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
	pattern = { "gitcommit", "markdown" },
	group = augroup "textFt",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 80
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup "lastLoc",
	callback = function()
		local exclude = { "gitcommit" }
		local buf = vim.api.nvim_get_current_buf()
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

-- show quickfix window automatically
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "[^l]*",
	command = "cwindow",
	nested = true,
})
