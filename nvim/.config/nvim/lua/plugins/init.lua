local configs = {
	"lspconfig",
	"treesitter",
	"telescope",
	"conform",
	"nvim-cmp",
	"luasnip",
	"gitsigns",
	"treesitter-context",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end

-- plugins which don't warrant their own file
require("mini.splitjoin").setup()
require("fidget").setup()
require("neoscroll").setup()
require("ts_context_commentstring").setup()
