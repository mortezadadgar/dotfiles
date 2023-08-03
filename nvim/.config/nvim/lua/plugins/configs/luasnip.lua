local ls = require "luasnip"

ls.config.set_config {
	history = false,
	delete_check_events = "TextChanged",
}

require("luasnip.loaders.from_vscode").lazy_load()
