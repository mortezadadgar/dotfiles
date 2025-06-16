vim.api.nvim_create_user_command("ToggleFormat", function()
	vim.g.autoformat = not vim.g.autoformat
	vim.notify(string.format("%s formatting", vim.g.autoformat and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Toggle conform.nvim auto-formatting", nargs = 0 })

vim.api.nvim_create_user_command("Scratch", function(opts)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_open_win(buf, true, { split = "below" })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	if #opts.args > 0 then
		vim.cmd("read " .. "!" .. opts.args)
	end
end, { desc = "Open a scratch buffer", nargs = "?", complete = "shellcmd" })
