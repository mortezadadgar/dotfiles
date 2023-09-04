vim.api.nvim_create_user_command(
	"Grep",
	"execute 'silent grep! -IRi <args> --exclude-dir=node_modules --exclude-dir=.git .' | copen",
	{ nargs = 1 }
)

vim.api.nvim_create_user_command(
	"Oldfiles",
	"browse filter /<args>/ oldfiles",
	{ nargs = 1 }
)
