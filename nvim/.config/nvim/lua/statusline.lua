local icons = {
	diagnostics = {
		error = "",
		warning = "",
		hint = "",
		info = "",
	},
	buffers = {
		readonly = "󰌾",
		modiefied = "●",
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
		local file_icon = nvim_devicons.get_icon("", ext)
		if file_icon then
			icon = string.format("%s ", file_icon)
		else
			icon = ""
		end
	end

	if vim.bo.modified and vim.bo.readonly then
		attr = icons.buffers.modiefied .. " " .. icons.buffers.readonly
	elseif vim.bo.readonly then
		attr = icons.buffers.readonly
	elseif vim.bo.modified then
		attr = icons.buffers.modiefied
	end

	if attr ~= "" then
		attr = string.format(" %s", attr)
	end

	if name == "" then
		name = "[No Name]"
	end

	return string.format("%s%s%s", icon, name, attr)
end

local function git_section()
	---@diagnostic disable-next-line: undefined-field
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
	return file_section() .. diagnostics_section()
end

local function right_section()
	return "%l:%L"
end

_G.set_statusline = function()
	return string.format(" %s%%=%s ", left_section(), right_section())
end

vim.o.statusline = "%!v:lua.set_statusline()"
