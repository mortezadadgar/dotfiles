local null_ls = require "null-ls"

null_ls.setup {
	sources = {
		null_ls.builtins.formatting.prettier.with {
			extra_args = { "--use-tabs" },
		},
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.diagnostics.shellcheck.with {
			extra_args = { "-e", "SC2034,SC2148" },
		},
	},
}
