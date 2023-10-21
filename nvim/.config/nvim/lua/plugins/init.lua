local configs = {
	"lspconfig",
	"treesitter",
	"telescope",
	"conform",
	"nvim-cmp",
	"luasnip",
	"treesitter-context",
	"oil",
	"mini-surround",
	"mini-comment",
	"mini-hipatterns",
	"undotree",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end
