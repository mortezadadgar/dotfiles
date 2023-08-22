local ls = require "luasnip"

ls.config.set_config {
	history = true,
	delete_check_events = "TextChanged",
	region_check_events = "InsertEnter",
}

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	ls.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
