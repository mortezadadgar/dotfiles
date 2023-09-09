-- Don't lose selection when shifting sidewards
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- include jumping with j and k to jumplist
vim.keymap.set("n", "k", [[(v:count > 0 ? "m'" . v:count : '') . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 0 ? "m'" . v:count : '') . 'j']], { expr = true })

-- better completion
vim.keymap.set("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<S-Tab>"]], { expr = true })
vim.keymap.set("i", "<CR>", [[pumvisible() ? "<C-y>" : "<CR>"]], { expr = true })

-- Spell checker
vim.keymap.set("n", "<Space>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- netrw
vim.keymap.set("n", "<Space>pv", ":Ex<CR>", { desc = "Netrw file explorer" })
