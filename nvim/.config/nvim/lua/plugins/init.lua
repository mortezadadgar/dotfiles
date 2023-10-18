local configs = {
	"lspconfig",
	"treesitter",
	"conform",
	"treesitter-context",
	"mini-completion",
	"nvim-snippy",
}

for _, config in pairs(configs) do
	require("plugins." .. config)
end

require("ts_context_commentstring").setup()
vim.keymap.set("n", "<Space>u", vim.cmd.UndotreeToggle)
