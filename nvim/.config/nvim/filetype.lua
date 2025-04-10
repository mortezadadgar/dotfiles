vim.filetype.add {
	pattern = {
		[".env"] = "config",
		[".env.*"] = "config",
		["config"] = "config",
	},
	extension = {
		templ = "html",
		tmpl = "html",
	},
}
