vim.pack.add {
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.notify" },
	{ src = "https://github.com/nvim-mini/mini.files" },
}

vim.keymap.set("n", "-", "<cmd>=MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>", { desc = "File explorer" })

require("mini.files").setup()
require("mini.notify").setup()
require("mini.icons").setup()
