vim.filetype.add {
	pattern = {
		[".env"] = "config",
		[".env.*"] = "config",
		["config"] = "config",
		["fstab.*"] = "fstab",
		["*.tmpl"] = "html",
		["*.gohtml"] = "html",
	},
	extension = {
		tmpl = "html",
		gohtml = "html",
	},
}
