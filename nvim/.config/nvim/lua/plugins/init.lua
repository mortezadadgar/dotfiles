local configs = {
	"gitsigns",
	"lspconfig",
	"treesitter",
	"mini-splitjoin",
	"formatter",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end
