-- Don't lose selection when shifting sidewards
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- traverse quicklist
vim.keymap.set("n", "<C-p>", ":cprevious<CR>", { desc = "Previous quicklist item" })
vim.keymap.set("n", "<C-n>", ":cnext<CR>", { desc = "Next quicklist item" })

-- include jumping with j and k to jumplist
vim.keymap.set("n", "k", [[(v:count > 0 ? "m'" . v:count : '') . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 0 ? "m'" . v:count : '') . 'j']], { expr = true })

-- Spell checker
vim.keymap.set("n", "<Space>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- netrw
vim.keymap.set("n", "<Space>pv", ":Ex<CR>", { desc = "Netrw file explorer" })
