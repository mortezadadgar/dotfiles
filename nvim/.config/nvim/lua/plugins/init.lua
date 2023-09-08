local configs = {
	"lspconfig",
	"treesitter",
	"mini-splitjoin",
	"telescope",
	"formatter",
	"nvim-cmp",
	"luasnip",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end
