local configs = {
	"lspconfig",
	"treesitter",
	"telescope",
	"conform",
	"nvim-cmp",
	"luasnip",
	"treesitter-context",
	"oil",
	"nvim-colorizer",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end

-- plugins which don't warrant their own file
require("fidget").setup()
require("ts_context_commentstring").setup()
vim.keymap.set("n", "<Space>u", vim.cmd.UndotreeToggle)
