-- Don't lose selection when shifting sidewards
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- better window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Spell checker
vim.keymap.set("n", "<Space>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- netrw
vim.keymap.set("n", "<Space>fm", ":Ex<CR>", { desc = "Netrw file explorer" })

-- traverse quicklist
vim.keymap.set("n", "<C-p>", ":cprevious<CR>", { desc = "Previous quicklist item" })
vim.keymap.set("n", "<C-n>", ":cnext<CR>", { desc = "Next quicklist item" })

-- cd to current buffer directory
vim.keymap.set(
	"n",
	"<leader>cd",
	"':cd ' . expand('%:p:h')",
	{ expr = true, desc = "Prompt to change directory to current buffer" }
)
