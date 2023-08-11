local function get_diagnostics_count()
	local results = {}
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
	local diagnostics_icons = {
		error = "",
		warning = "",
		hint = "",
		info = "",
	}

	local results = {}
	for key, value in pairs(diagnostics_icons) do
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
			return "[*]"
		end
		::continue::
	end

	return ""
end

local function left_section()
	return " %t%( %m%) " .. unsaved_buffers() .. " %( %r%)%( %h%)" .. diagnostics_section()
end

local function right_section()
	return " %l:%L "
end

_G.set_statusline = function()
	return left_section() .. "%=" .. right_section()
end

vim.o.statusline = [[%!luaeval('set_statusline()')]]
