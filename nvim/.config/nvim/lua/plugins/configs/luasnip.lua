local ls = require "luasnip"

ls.config.set_config {
	history = true,
	delete_check_events = "TextChanged",
}

require("luasnip.loaders.from_vscode").lazy_load()
