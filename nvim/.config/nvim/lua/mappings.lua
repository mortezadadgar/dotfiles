-- map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- quickfix
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")

-- misc
vim.keymap.set("n", ",m", "<cmd>marks<CR>")
vim.keymap.set("n", ",r", "<cmd>registers<CR>")
vim.keymap.set("n", ",o", "<cmd>setlocal spell!<CR>")
