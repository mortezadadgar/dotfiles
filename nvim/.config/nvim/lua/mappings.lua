local map = vim.keymap.set

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
map("n", "<Space><Space>", ":Telescope find_files<CR>")
map("n", "<Space>b", ":Telescope buffers<CR>")
map("n", "<Space>k", ":Telescope keymaps<CR>")
map("n", "<Space>g", ":vim //j **<S-Left><S-Left><Right>")

-- Spell checker
map("n", "<leader>o", ":setlocal spell!<CR>", { desc = "Spell Checker" })
