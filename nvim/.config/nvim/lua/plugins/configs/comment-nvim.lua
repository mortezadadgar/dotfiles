local ft = require "Comment.ft"

require("Comment").setup {
	ignore = "^$",
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}

ft.set("c", "/*%s*/")
