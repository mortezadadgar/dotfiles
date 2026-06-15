-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

require "options"
require "keymaps"
require "autocmd"

local plugins = {
	"blink",
	"colorscheme",
	"conform",
	"fzflua",
	"gitlinker",
	"gitsigns",
	"mini",
	"lsp",
	"neoscroll",
	"treesitter",
	"sleuth",
	-- "surround",
	"gx-extended",
}

for _, plugin in ipairs(plugins) do
	require("plugins." .. plugin)
end

vim.cmd "packadd nvim.undotree"
vim.cmd "packadd nvim.difftool"
