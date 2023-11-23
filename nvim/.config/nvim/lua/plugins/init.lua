local configs = {
	"lspconfig",
	"conform",
	"treesitter",
	"telescope",
	"treesitter-context",
	"nvim-cmp",
	"luasnip",
	"gitsigns",
	"fidget",
	"oil",
	"mini-pairs",
	"mini-comment",
	"mini-splitjoin",
	"mini-hipatterns",
	"nvim-surround",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end
