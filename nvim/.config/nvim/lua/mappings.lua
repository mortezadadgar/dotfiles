-- C-c is not quite same as Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Indent while remaining in visual mode
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Shift visual selections
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

-- Alias :W to saving files
vim.keymap.set("ca", "W", "w")

-- spell check
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<cr>", { desc = "Toggle spell checking" })

-- gF is just better
vim.keymap.set("n", "gf", "gF")

-- Select last inserted text
vim.keymap.set("n", "gV", "`[v`]", { desc = "Select last inserted text" })

-- Repeat last command for each line of a visual selection
vim.keymap.set("x", ".", ":normal .<cr>", { silent = true })
