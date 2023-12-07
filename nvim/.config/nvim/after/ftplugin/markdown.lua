-- sensible default options
vim.opt_local.spell = true
vim.opt_local.textwidth = 80

-- previewing md files
vim.api.nvim_create_user_command(
	"View",
	":silent !litemdview %:p & disown",
	{ desc = "Preview markdown in litemdview" }
)
