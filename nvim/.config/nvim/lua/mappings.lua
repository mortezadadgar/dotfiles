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

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Map C-c to Esc
map("i", "<C-c>", "<Esc>")

-- dont override clipboard on paste
map("x", "<Space>p", [["_dP]])

-- fuzzy finder
map("n", "<Space><Space>", t.find_files, { desc = "Telescope: find files" })
map("n", "<leader><leader>", t.resume, { desc = "Telescope: Resume" })
map("n", "<Space>b", t.buffers, { desc = "Telescope: Buffers" })
map("n", "<Space>k", t.keymaps, { desc = "Telescope: Keymaps" })
map("n", "<Space>g", t.live_grep, { desc = "Telescope: Live grep" })
map("n", "<Space>v", t.grep_string, { desc = "Telescope: Grep string" })
map("n", "<Space>o", t.oldfiles, { desc = "Telescope: Old files" })

-- Spell checker
map("n", "<Space>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- file explorer
map("n", "<Space>pv", ":lua MiniFiles.open()<CR>", { desc = "Mini file explorer" })

-- undotree
map("n", "<Space>u", ":UndotreeToggle<CR>", { desc = "Undo tree" })
