local configs = {
	"gitsigns",
	"lspconfig",
	"telescope",
	"treesitter",
	"luasnip",
	"nvim-cmp",
	"mini-splitjoin",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end
