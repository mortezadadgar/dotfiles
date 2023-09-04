require("formatter").setup {
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		html = {
			require("formatter.filetypes.html").prettierd,
		},
		css = {
			require("formatter.filetypes.css").prettierd,
		},
	},
}

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "<buffer>",
	command = "FormatWrite",
})
