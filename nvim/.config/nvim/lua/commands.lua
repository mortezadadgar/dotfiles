vim.api.nvim_create_user_command("ToggleFormat", function()
	vim.g.autoformat = not vim.g.autoformat
	vim.notify(string.format("%s formatting", vim.g.autoformat and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Toggle conform.nvim auto-formatting", nargs = 0 })
