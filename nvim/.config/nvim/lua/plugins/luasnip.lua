local ls = require "luasnip"

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	ls.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()

ls.filetype_extend("svelte", { "html", "css" })
