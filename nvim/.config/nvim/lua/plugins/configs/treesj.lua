local ts = require "treesj"
ts.setup {
	use_default_keymaps = false,
}
vim.keymap.set("n", "gS", ts.toggle, { desc = "Treesj: Toggle splitting" })
