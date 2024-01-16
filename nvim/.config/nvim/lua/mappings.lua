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

-- Better windows resizing
vim.keymap.set("n", "<C-w><Right>", "<cmd>vert resize -10<CR>")
vim.keymap.set("n", "<C-w><Left>", "<cmd>vert resize +10<CR>")
vim.keymap.set("n", "<C-w><Up>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<C-w><Down>", "<cmd>resize -5<CR>")

-- spell check
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>")
