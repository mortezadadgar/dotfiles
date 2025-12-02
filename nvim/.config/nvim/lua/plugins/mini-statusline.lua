return {
	"nvim-mini/mini.statusline",
	version = "*",
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		local ministatusline = require "mini.statusline"
		ministatusline.setup {
			content = {
				active = function()
					local mode, mode_hl = ministatusline.section_mode { trunc_width = 120 }
					local git = ministatusline.section_git { trunc_width = 40 }
					local diff = ministatusline.section_diff { trunc_width = 75 }
					local diagnostics = ministatusline.section_diagnostics { trunc_width = 75 }
					local filename = ministatusline.section_filename { trunc_width = 999 }
					local fileinfo = ministatusline.section_fileinfo { trunc_width = 999 }

					return ministatusline.combine_groups {
						{ hl = mode_hl, strings = { mode } },
						{ hl = "ministatuslineDevinfo", strings = { git, diff, diagnostics } },
						"%<", -- Mark general truncate point
						{ hl = "ministatuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						{ hl = "ministatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { "%l:%L" } },
					}
				end,
			},
		}
	end,
}
