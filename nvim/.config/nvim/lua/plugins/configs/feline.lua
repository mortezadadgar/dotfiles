local lsp = require "feline.providers.lsp"
local vi_mode = require "feline.providers.vi_mode"

local colors = {
	bg = "#282c34",
	fg = "#abb2bf",
	green = "#98c379",
	red = "#e06c75",
	blue = "#61afef",
	yellow = "#e5c07b",
	grey = "#6f737b",
}

local vi_mode_colors = {
	NORMAL = "blue",
	INSERT = "green",
	VISUAL = "yellow",
	BLOCK = "yellow",
	LINES = "yellow",
	SELECT = "grey",
	COMMAND = "blue",
	REPLACE = "red",
	["V-REPLACE"] = "yellow",
	TERM = "blue",
}

local components = {
	active = { {}, {}, {} },
	inactive = { {}, {} },
}

components.active[1][1] = {
	provider = "vi_mode",
	hl = function()
		return {
			name = vi_mode.get_mode_highlight_name(),
			fg = vi_mode.get_mode_color(),
			bg = "bg",
			style = "bold",
		}
	end,
	left_sep = " ",
	right_sep = " ",
	icon = "",
}

components.active[1][2] = {
	provider = {
		name = "file_info",
		opts = {
			colored_icon = false,
		},
	},
	hl = {
		bg = "bg",
	},
	right_sep = "",
	icon = "",
}

components.active[1][3] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist "Error"
	end,
	hl = {
		fg = "red",
	},
	icon = "  ",
	truncate_hide = true,
}

components.active[1][4] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist "Warn"
	end,
	hl = {
		fg = "yellow",
	},
	icon = "  ",
	truncate_hide = true,
}

components.active[1][5] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist "Info"
	end,
	hl = {
		fg = "blue",
	},
	icon = "  ",
	truncate_hide = true,
}

components.active[1][6] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist "Hint"
	end,
	hl = {
		fg = "blue",
	},
	icon = "  ",
	truncate_hide = true,
}

components.active[3][1] = {
	provider = function()
		return string.format("%i:%i", vim.fn.line ".", vim.fn.line "$")
	end,
	hl = {
		bg = "bg",
		fg = "grey",
	},
	right_sep = " ",
	truncate_hide = true,
	priority = 1,
}

require("feline").setup {
	theme = colors,
	vi_mode_colors = vi_mode_colors,
	components = components,
}
