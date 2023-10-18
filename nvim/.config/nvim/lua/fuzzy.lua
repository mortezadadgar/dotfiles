local files_picker = function(arg)
	local items = vim.fn.glob("**", 0, 1)
	return vim.fn.matchfuzzy(items, arg, { limit = 10 })
end

vim.api.nvim_create_user_command("Files", function(opts)
	vim.cmd.edit(opts.fargs[1])
end, {
	nargs = 1,
	complete = function(arg, _, _)
		return files_picker(arg)
	end,
})

vim.keymap.set("n", "<Space><Space>", ":Files ")

vim.api.nvim_create_user_command("Grep", function(opts)
	vim.cmd.grep {
		args = { opts.fargs[1], "**" },
		mods = { silent = true },
		bang = true,
	}
end, { nargs = 1 })

vim.keymap.set("n", "<Space>g", ":Grep ")

vim.keymap.set("n", "<Space>b", ":ls<CR>:buffer<Space>")

vim.api.nvim_create_user_command("OldFiles", function(opts)
	vim.cmd(string.format("filter /%s/ browse oldfiles", opts.fargs[1]))
end, { nargs = 1 })

vim.keymap.set("n", "<Space>o", ":OldFiles<CR>")
