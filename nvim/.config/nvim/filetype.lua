vim.filetype.add {
	pattern = {
		[".env"] = "config",
		[".env.*"] = "config",
		["config"] = "config",
		["fstab.*"] = "fstab",
	},
	extension = {
		templ = "html",
		tmpl = "html",
	},
}
