local map = vim.keymap.set

vim.g.mapleader = " "

-- better window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Don't lose selection when shifting sidewards
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Map C-c to Esc
map("i", "<C-c>", "<Esc>")

-- fuzzy finder
map("n", "<leader><leader>", ":find *")
map("n", "<leader>b", ":ls<CR>:b<leader>")
map("n", "<leader>g", ":vim //j **<S-Left><S-Left><Right>")

-- Spell checker
map("n", "<leader>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- file explorer
map("n", "<leader>pv", ":Ex<CR>")

-- undotree
map("n", "<leader>u", ":UndotreeToggle<CR>")

-- usefull maps
map("x", "<leader>p", [["_dP]])
