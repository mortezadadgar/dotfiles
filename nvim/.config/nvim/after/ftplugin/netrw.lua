-- make sure the buffer is not floating around
vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })

vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir", { buffer = true })
vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck", { buffer = true })
