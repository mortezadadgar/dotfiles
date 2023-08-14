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
		unsaved_others = "○",
	},
}

local function get_diagnostics_count()
	local results = {}
	-- this table must be keep in sync with icons.diagnostics keys
	local severity = {
		error = vim.diagnostic.severity.ERROR,
		warning = vim.diagnostic.severity.WARN,
		hint = vim.diagnostic.severity.HINT,
		info = vim.diagnostic.severity.INFO,
	}

	for key, value in pairs(severity) do
		results[key] = #vim.diagnostic.get(0, { severity = value })
	end

	return results
end

local function diagnostics_section()
	if #vim.lsp.get_active_clients() == 0 then
		return ""
	end

	local diagnostics_count = get_diagnostics_count()

	local results = {}
	for key, value in pairs(icons.diagnostics) do
		if diagnostics_count[key] > 0 then
			local diagnostic = " " .. diagnostics_count[key] .. " " .. value
			table.insert(results, diagnostic)
		end
	end

	return table.concat(results)
end

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
	local file_name, file_ext = vim.fn.expand "%:t", vim.fn.expand "%:e"
	local file_icon = require("nvim-web-devicons").get_icon("", file_ext, { default = true })

	if vim.bo.modified and vim.bo.readonly then
		file_attr = icons.buffers.modiefied .. " " .. icons.buffers.readonly
	elseif vim.bo.readonly then
		file_attr = icons.buffers.readonly
	elseif vim.bo.modified then
		file_attr = icons.buffers.modiefied
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
	return file_section() .. unsaved_buffers() .. diagnostics_section()
end

local function right_section()
	return "%l:%L"
end

_G.set_statusline = function()
	return " " .. left_section() .. "%=" .. right_section() .. " "
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	pattern = "<buffer>",
	command = "set statusline=%!v:lua.set_statusline()",
})
