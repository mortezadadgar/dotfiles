require("gitsigns").setup {
	signcolumn = false,
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame_opts = {
		delay = 500,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "<space>hs", gs.stage_hunk)
		map("n", "<space>hr", gs.reset_hunk)
		map("n", "<space>hS", gs.stage_buffer)
		map("n", "<space>hu", gs.undo_stage_hunk)
		map("n", "<space>hR", gs.reset_buffer)
		map("n", "<space>hp", gs.preview_hunk)
		map("n", "<space>hd", gs.diffthis)
		map("n", "<space>hd", gs.diffthis)
		map("n", "<space>hi", gs.toggle_signs)
		map("n", "<space>hB", function()
			gs.blame_line { full = true }
		end)
		map("n", "<space>hb", gs.toggle_current_line_blame)
	end,
}
