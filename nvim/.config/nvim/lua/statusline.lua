local icons = {
	diagnostics = {
		error = "E",
		warning = "W",
		hint = "H",
		info = "I",
	},
	buffers = {
		readonly = "[RO]",
		modified = "[+]",
	},
}

local diagnostics_attrs = {
	{ "Error", icons.diagnostics.error },
	{ "Warn", icons.diagnostics.warning },
	{ "Hint", icons.diagnostics.hint },
	{ "Info", icons.diagnostics.info },
}

local function diagnostics_section()
	local results = {}

	for _, attr in pairs(diagnostics_attrs) do
		local n = vim.diagnostic.get(0, { severity = attr[1] })
		if #n > 0 then
			table.insert(results, string.format(" %d %s", #n, attr[2]))
		end
	end

	return table.concat(results)
end

local function file_section()
	local name = vim.fn.expand "%:~:."

	if name == "" then
		name = "[No Name]"
	end

	return string.format("%s %%h%%q%%r%%m", name)
end

local function git_section()
	---@diagnostic disable-next-line: undefined-field
	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end

	return string.format("%s", head)
end

local function spell_section()
	if not vim.wo.spell then
		return ""
	end

	return string.format(" %s %s", icons.buffers.spell, vim.o.spelllang)
end

local function left_section()
	return file_section() .. diagnostics_section()
end

local function right_section()
	return "%l:%L"
end

_G.set_statusline = function()
	return string.format(" %s%%=%s ", left_section(), right_section())
end

vim.o.statusline = "%!v:lua.set_statusline()"
