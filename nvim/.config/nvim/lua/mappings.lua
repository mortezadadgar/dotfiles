-- C-c is not quite same as Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Indent while remaining in visual mode
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Keeping the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Shift visual selections
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

-- aliases :W to saving files
vim.keymap.set("ca", "W", "w")

-- spell check
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>")

-- quickfix
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")

-- gF is a better version of gf
vim.keymap.set("n", "gf", "gF")
