-- Load custom treesitter grammar for org filetype
require("orgmode").setup_ts_grammar()

require("orgmode").setup {
	org_default_notes_file = "~/notes",
}
