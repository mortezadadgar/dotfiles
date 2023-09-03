local group = vim.api.nvim_create_augroup("StatusLine", { clear = true })

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
		unsaved_others = "○",
	},
}

local diagnostics_attrs = {
	{ "Error", icons.diagnostics.error },
	{ "Warn", icons.diagnostics.warning },
	{ "Hint", icons.diagnostics.hint },
	{ "Info", icons.diagnostics.info },
}

local diagnostics = ""
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

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufWinEnter" }, {
	group = group,
	callback = function()
		diagnostics = diagnostics_section()
	end,
})

local function unsaved_buffers()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_get_current_buf() == buf then
			goto continue
		end
		if vim.api.nvim_buf_get_option(buf, "modified") then
			return string.format(" %s ", icons.buffers.unsaved_others)
		end
		::continue::
	end

	return ""
end

local function file_section()
	local file_attr = ""
	local file_icon = ""
	local file_name, file_ext = vim.fn.expand "%:t", vim.fn.expand "%:e"

	local ok, nvim_devicons = pcall(require, "nvim-web-devicons")
	if ok then
		file_icon = nvim_devicons.get_icon("", file_ext, { default = true })
	end

	if vim.bo.modified and vim.bo.readonly then
		file_attr = icons.buffers.modified .. " " .. icons.buffers.readonly
	elseif vim.bo.readonly then
		file_attr = icons.buffers.readonly
	elseif vim.bo.modified then
		file_attr = icons.buffers.modified
	end

	if file_attr ~= "" then
		file_attr = " " .. file_attr
	end

	if file_name == "" then
		file_name = "No Name"
	end

	return string.format("%s %s%s", file_icon, file_name, file_attr)
end

local function left_section()
	return file_section() .. unsaved_buffers() .. diagnostics
end

local function right_section()
	return "%l:%L"
end

_G.set_statusline = function()
	return " " .. left_section() .. "%=" .. right_section() .. " "
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	command = "setlocal statusline=%!v:lua.set_statusline()",
})
