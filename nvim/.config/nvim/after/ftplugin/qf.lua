vim.opt_local.buflisted = false

vim.keymap.set("n", "<C-o>", "<cmd>colder<CR>", { buffer = true })
vim.keymap.set("n", "<C-i>", "<cmd>cnewer<CR>", { buffer = true })

vim.cmd.packadd "cfilter"
