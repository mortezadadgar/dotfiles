-- make netrw behave sane
vim.g.netrw_banner = 0
vim.g.netrw_alto = 0
vim.g.netrw_winsize = 20
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_list_hide = "^\\./$,^\\.\\./$"

vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir", { buffer = true })
vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck", { buffer = true })
vim.keymap.set("n", "q", "<cmd>q<CR>", { nowait = true, buffer = true })
