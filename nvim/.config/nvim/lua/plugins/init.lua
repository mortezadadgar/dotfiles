local configs = {
	"lspconfig",
	"treesitter",
	"telescope",
	"formatter",
	"nvim-cmp",
	"luasnip",
	"mini-splitjoin",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end
