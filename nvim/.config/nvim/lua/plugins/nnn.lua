local builtin = require("nnn").builtin
require("nnn").setup {
	explorer = {
		with = 30,
	},
	replace_netrw = "explorer",
	mappings = {
		{ "<C-t>", builtin.open_in_tab },
		{ "<C-x>", builtin.open_in_split },
		{ "<C-v>", builtin.open_in_vsplit },
		{ "<C-y>", builtin.copy_to_clipboard },
		{ "<C-w>", builtin.cd_to_path },
		{ "<C-e>", builtin.populate_cmdline },
	},
}

vim.keymap.set("n", "<space>fe", "<cmd>NnnExplorer<CR>")
