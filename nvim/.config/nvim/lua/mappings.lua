-- map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- include navigating with j and k to jumplist
vim.keymap.set("n", "k", [[(v:count > 3 ? "m'" . v:count : '') . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 3 ? "m'" . v:count : '') . 'j']], { expr = true })

-- spell checker
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>", { desc = "Spell Checker" })

-- cd to current buffer directory
vim.keymap.set(
	"n",
	"<leader>cd",
	"':cd ' . expand('%:p:h')",
	{ expr = true, desc = "Prompt to change directory to current buffer" }
)

-- quickfix
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")
