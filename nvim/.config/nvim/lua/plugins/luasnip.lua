return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require "luasnip"
		ls.setup {
			keep_roots = true,
			link_roots = true,
			link_children = true,
			exit_roots = false,
			delete_check_events = "TextChanged",
		}

		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.locally_jumpable(1) then
				ls.jump(1)
			end
		end)
		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if ls.locally_jumpable(-1) then
				ls.jump(-1)
			end
		end)

		require("luasnip.loaders.from_vscode").lazy_load()
		ls.filetype_extend("svelte", { "html", "css" })
	end,
}
