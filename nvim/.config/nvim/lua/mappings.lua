local map = vim.keymap.set

-- better window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Don't lose selection when shifting sidewards
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Map C-c to Esc
map("i", "<C-c>", "<Esc>")

-- dont override clipboard on paste
map("x", "<Space>p", [["_dP]])

-- Spell checker
map("n", "<Space>s", ":setlocal spell!<CR>", { desc = "Spell Checker" })

-- netrw
map("n", "<Space>pv", ":Ex<CR>", { desc = "Netrw file explorer" })

-- better completion
local function map_completion(lhs, rhs)
	map("i", lhs, function()
		return vim.fn.pumvisible() ~= 0 and rhs or lhs
	end, { expr = true })
end
map_completion("<TAB>", "<C-n>")
map_completion("<S-TAB>", "<C-p>")
map_completion("<CR>", "<C-y>")
