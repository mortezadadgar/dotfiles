-- C-c is not quite same as Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Reselect latest changed, put, or yanked text
vim.keymap.set("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false })

-- Indent while remaining in visual mode.
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Keeping the cursor centered.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- spell check
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>")
