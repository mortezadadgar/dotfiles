-- Don't lose selection when shifting sidewards
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- better window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Map C-c to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Spell checker
vim.keymap.set("n", "<Space>s", "<cmd>setlocal spell!<CR>", { desc = "Spell Checker" })

-- netrw
vim.keymap.set("n", "<Space>pv", "<cmd>Ex<CR>", { desc = "Netrw file explorer" })

-- traverse quicklist
vim.keymap.set("n", "<C-p>", "<cmd>cprevious<CR>", { desc = "Previous quicklist item" })
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Next quicklist item" })

-- cd to current buffer directory
vim.keymap.set(
	"n",
	"<leader>cd",
	"':cd ' . expand('%:p:h')",
	{ expr = true, desc = "Prompt to change directory to current buffer" }
)

-- include jumping with j and k to jumplist
vim.keymap.set("n", "k", [[(v:count > 0 ? "m'" . v:count : '') . 'k']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 0 ? "m'" . v:count : '') . 'j']], { expr = true })

-- finder
vim.keymap.set("n", "<Space><Space>", ":find ")
vim.keymap.set("n", "<Space>b", ":ls<CR>:buffer ")
vim.keymap.set("n", "<Space>g", ":Grep ")
vim.keymap.set("n", "<Space>o", ":Oldfiles ")
