local configs = {
	"lspconfig",
	"telescope",
	"conform",
	"nvim-cmp",
	"luasnip",
	"treesitter",
	"treesitter-context",
	"oil",
	"mini-hipatterns",
	"undotree",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end

require("ts_context_commentstring").setup()
require("mini.splitjoin").setup()
