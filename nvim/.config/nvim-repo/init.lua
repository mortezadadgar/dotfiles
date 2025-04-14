-- Clone latest 'mini.nvim' (requires Git CLI installed)
vim.cmd 'echo "Installing `mini.nvim`" | redraw'
local mini_path = vim.fn.stdpath "data" .. "/site/pack/deps/start/mini.nvim"
local clone_cmd = { "git", "clone", "--depth=1", "https://github.com/echasnovski/mini.nvim", mini_path }
vim.fn.system(clone_cmd)
vim.cmd 'echo "`mini.nvim` is installed" | redraw'

-- Make sure 'mini.nvim' is available
vim.cmd "packadd mini.nvim"
require("mini.deps").setup()

MiniDeps.add "neovim/nvim-lspconfig"
require("lspconfig").tailwindcss.setup {}
require("lspconfig").svelte.setup {}
require("lspconfig").ts_ls.setup {}

require("mini.completion").setup()
vim.opt.completeopt:append { "fuzzy" }
