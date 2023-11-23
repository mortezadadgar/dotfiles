local icons = {
	diagnostics = {
		error = "",
		warning = "",
		hint = "",
		info = "",
	},
	buffers = {
		readonly = "󰌾",
		modified = "●",
		spell = "󰓆",
		git = "",
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
	local name, ext = vim.fn.expand "%:~:.", vim.fn.expand "%:e"
	local attr, icon = "", ""

	local ok, nvim_devicons = pcall(require, "nvim-web-devicons")
	if ok then
		icon = nvim_devicons.get_icon("", ext, { default = true })
	end

	if vim.bo.modified and vim.bo.readonly then
		attr = icons.buffers.modified .. " " .. icons.buffers.readonly
	elseif vim.bo.readonly then
		attr = icons.buffers.readonly
	elseif vim.bo.modified then
		attr = icons.buffers.modified
	end

	if attr ~= "" then
		attr = attr .. " "
	end

	if name == "" then
		name = "No Name"
	end

	return string.format("%%#Visual# %s %s %s%%*", icon, name, attr)
end

local function git_section()
	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end

	return string.format("%s %s ", icons.buffers.git, head)
end

local function spell_section()
	if not vim.wo.spell then
		return ""
	end

	return string.format(" %s %s", icons.buffers.spell, vim.o.spelllang)
end

local function left_section()
	return file_section()
end

local function right_section()
	return string.format("%s %s%%#Visual# %%l:%%L %%*", spell_section(), git_section())
end

_G.set_statusline = function()
	return string.format("%s%%=%s", left_section(), right_section())
end

vim.o.statusline = "%!v:lua.set_statusline()"
