-- C-c is not quite same as Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Indent while remaining in visual mode.
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Keeping the cursor centered.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
vim.keymap.set("n", "n", "nzz", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzz", { desc = "Previous search result" })

-- spell check
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>", { desc = "Toggle spell checking" })

-- netrw
vim.keymap.set("n", "<leader>fe", "<cmd>Explorer<CR>", { desc = "Netrw file explorer" })
