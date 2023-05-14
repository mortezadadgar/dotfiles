local map = vim.keymap.set
local t = require "telescope.builtin"

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

-- usefull maps
map("x", "<Space>p", [["_dP]])

-- fuzzy finder
map("n", "<Space><Space>", t.find_files, { desc = "Telescope: find files" })
map("n", "<leader><leader>", t.resume, { desc = "Telescope: Resume" })
map("n", "<Space>b", t.buffers, { desc = "Telescope: Buffers" })
map("n", "<Space>k", t.keymaps, { desc = "Telescope: Keymaps" })
map("n", "<Space>g", t.live_grep, { desc = "Telescope: Live grep" })
map("n", "<Space>s", t.grep_string, { desc = "Telescope: Grep string" })

-- Spell checker
map("n", "<Space>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- file explorer
map("n", "<Space>pv", ":Ex<CR>", { desc = "Netrw file explorer" })

-- undotree
map("n", "<Space>u", ":UndotreeToggle<CR>", { desc = "Undo tree" })
