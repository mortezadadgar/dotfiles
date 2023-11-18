local configs = {
	"lspconfig",
	"conform",
	"treesitter",
	"telescope",
	"nvim-cmp",
	"luasnip",
	"gitsigns",
	"fidget",
	"nnn",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end

require("ts_context_commentstring").setup()
require("neogit").setup {}
