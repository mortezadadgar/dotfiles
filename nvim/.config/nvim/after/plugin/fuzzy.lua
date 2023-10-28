-- keeping it here for future references
if 0 then
	return
end

local find = function(arg)
	local out = vim.fn.systemlist { "rg", "--files" }
	if #out == 0 or vim.v.shell_error ~= 0 then
		return
	end
	return vim.fn.matchfuzzy(out, arg)
end

vim.api.nvim_create_user_command("Files", function(opts)
	local path = opts.fargs[1]
	if not vim.loop.fs_stat(path) then
		vim.notify("Can't find file " .. path, vim.log.levels.ERROR)
		return
	end
	vim.cmd.edit(path)
end, {
	nargs = 1,
	complete = function(arg, _, _)
		return find(arg)
	end,
})

vim.keymap.set("n", "<Space><Space>", ":Files ")

vim.api.nvim_create_user_command("Grep", function(opts)
	local fargs = opts.fargs
	local args = { fargs[1] }

	if fargs[2] ~= nil then
		table.insert(args, string.format(" --iglob '%s'", fargs[2]))
	end

	vim.cmd.grep {
		args = { table.concat(args) },
		mods = { silent = true },
		bang = true,
	}

	vim.fn.matchadd("MatchParen", opts.fargs[1])
end, { nargs = "+" })

vim.keymap.set("n", "<Space>lg", ":Grep ")
vim.keymap.set("n", "<Space>gs", ":Grep <cword><CR>")
