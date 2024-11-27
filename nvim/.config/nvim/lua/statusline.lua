local M = {}

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
	{ vim.diagnostic.severity.ERROR, icons.diagnostics.error },
	{ vim.diagnostic.severity.WARN,  icons.diagnostics.warning },
	{ vim.diagnostic.severity.HINT,  icons.diagnostics.hint },
	{ vim.diagnostic.severity.INFO,  icons.diagnostics.info },
}

--- Diagnostics count in current buffer.
---@return string
function M.diagnostics_component()
	---@type table<string>
	local results = {}

	for _, attr in pairs(diagnostics_attrs) do
		local n = vim.diagnostic.get(0, { severity = attr[1] })
		if #n > 0 then
			table.insert(results, string.format(" %d %s", #n, attr[2]))
		end
	end

	return table.concat(results)
end

--- Current buffer's file info.
---@return string
function M.file_component()
	local name = vim.fn.expand "%:~:."
	local attr, icon = "", ""

	local ok, nvim_devicons = pcall(require, "nvim-web-devicons")
	if ok then
		local file_icon = nvim_devicons.get_icon_by_filetype(vim.o.filetype)
		if file_icon then
			icon = string.format("%s ", file_icon)
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

--- Git status.
---@return string
function M.git_component()
	if vim.b.gitsigns_head == nil then
		vim.print "gitsigns in not installed"
		return ""
	end

	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end

	return string.format("%s %s ", icons.buffers.git, head)
end

--- Spell check status.
---@return string
function M.spell_component()
	if not vim.wo.spell then
		return ""
	end

	return string.format(" %s %s ", icons.buffers.spell, vim.o.spelllang)
end

--- Current buffer's line number info.
---@return string
function M.line_component()
	return "%l:%L"
end

--- Renders statusline components.
---@return string
function M.render()
	-- stylua: ignore
	return
	-- right section
		" " ..
		M.file_component() .. M.diagnostics_component() ..

		"%=" ..

		-- left section
		M.spell_component() .. M.line_component() ..
		" "
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M
