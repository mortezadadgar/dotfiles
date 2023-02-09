require("nvim-tree").setup {
	view = {
		width = 25,
		hide_root_folder = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
}
