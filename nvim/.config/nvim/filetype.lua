vim.filetype.add {
	pattern = {
		[".env"] = "config",
		[".env.*"] = "config",
	},
	extension = {
		templ = "html",
		tmpl = "html",
	},
}
