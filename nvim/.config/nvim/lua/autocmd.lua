local group = vim.api.nvim_create_augroup("UserGroup", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank and set tmux buffer",
	group = group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()

		local reg = vim.fn.getreg [["]]
		local _, count = reg:gsub("\n", "\n")
		if count < 450 then
			vim.system { "tmux", "set-buffer", "-w", reg }
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disable auto commenting",
	group = group,
	callback = function()
		vim.opt.formatoptions:remove { "c", "r", "o" }
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	desc = "Resize splits if window got resized",
	group = group,
	command = "tabdo wincmd =",
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

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "Reload Xresources",
	pattern = "Xresources",
	callback = function()
		local cmd = vim.system({ "xrdb", vim.fn.expand "$XDG_CONFIG_HOME/x11/Xresources" }):wait()
		if cmd.code > 0 then
			vim.notify(cmd.stderr, vim.log.levels.ERROR)
		end
	end,
})
