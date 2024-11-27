require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"markdown_inline",
	},

	ignore_install = {
		"ini",
		"vim",
		"sql",
	},

	auto_install = true,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},
}
