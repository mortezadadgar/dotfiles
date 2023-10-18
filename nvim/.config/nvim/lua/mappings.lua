-- Map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- include jumping with j and k to jumplist
vim.keymap.set("n", "k", [[(v:count > 3 ? "m'" . v:count : '') . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 3 ? "m'" . v:count : '') . 'j']], { expr = true })

-- Spell checker
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<CR>", { desc = "Spell Checker" })

-- cd to current buffer directory
vim.keymap.set(
	"n",
	"<leader>cd",
	"':cd ' . expand('%:p:h')",
	{ expr = true, desc = "Prompt to change directory to current buffer" }
)

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<S-Tab>"]], { expr = true })
vim.keymap.set("i", "<CR>", [[pumvisible() ? "<C-y>" : "<CR>"]], { expr = true })

vim.keymap.set("n", "-", "<cmd>:Ex<CR>")
