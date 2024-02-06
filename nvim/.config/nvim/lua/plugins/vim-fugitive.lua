return {
	"tpope/vim-fugitive",
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "<space>p", "<cmd>Git -c push.default=current push<CR>", opts)
				vim.keymap.set("n", "<space>t", ":Git push -u origin <C-z>", opts)
				vim.keymap.set("n", "<space>P", "<cmd>Git pull --autostash<CR>", opts)
				-- vim.keymap.set("n", "<Tab>", "=", { buffer = ev.buf, nowait = true })
			end,
		})
	end,
}
