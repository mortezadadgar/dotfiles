vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd "bel 15new"
	local buf = vim.api.nvim_get_current_buf()
	for name, value in pairs {
		filetype = "scratch",
		buftype = "nofile",
		bufhidden = "hide",
	} do
		vim.api.nvim_set_option_value(name, value, { buf = buf })
	end
end, { desc = "Open a scratch buffer", nargs = 0 })
