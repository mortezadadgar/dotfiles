-- map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- quickfix
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")

-- Reselect latest changed, put, or yanked text
vim.keymap.set("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false })

-- misc
vim.keymap.set("n", "<leader>u", "<cmd>undolist<CR>:silent undo ")
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>")
