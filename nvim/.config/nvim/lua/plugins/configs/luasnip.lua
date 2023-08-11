local ls = require "luasnip"
local map = vim.keymap.set

ls.config.set_config {
	history = false,
	delete_check_events = "TextChanged",
}

map({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })
map({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })
map({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
