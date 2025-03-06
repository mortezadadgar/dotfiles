return {
	"echasnovski/mini.hipatterns",
	config = function()
		require("mini.hipatterns").setup {
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "DiagnosticError" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "DiagnosticHint" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "DiagnosticInfo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "DiagnosticWarn" },
				done = { pattern = "%f[%w]()DONE()%f[%W]", group = "SpecialChar" },
				hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
			},
		}
	end
}
