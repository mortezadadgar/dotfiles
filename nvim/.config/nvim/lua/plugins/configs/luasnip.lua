local ls = require("luasnip")

ls.config.set_config({
	region_check_events = "InsertEnter",
})

require("luasnip.loaders.from_vscode").lazy_load()
