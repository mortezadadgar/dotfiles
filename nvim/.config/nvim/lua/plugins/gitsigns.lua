return {
	"lewis6991/gitsigns.nvim",
	opts = {
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
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns
			local opts = { buffer = buffer }

			vim.keymap.set("n", "]c", gs.next_hunk, opts)
			vim.keymap.set("n", "[c", gs.prev_hunk, opts)
			vim.keymap.set("n", "<space>hs", gs.stage_hunk, opts)
			vim.keymap.set("n", "<space>hr", gs.reset_hunk, opts)
			vim.keymap.set("n", "<space>hS", gs.stage_buffer, opts)
			vim.keymap.set("n", "<space>hu", gs.undo_stage_hunk, opts)
			vim.keymap.set("n", "<space>hR", gs.reset_buffer, opts)
			vim.keymap.set("n", "<space>hN", gs.reset_buffer_index, opts)
			vim.keymap.set("n", "<space>hp", gs.preview_hunk, opts)
			vim.keymap.set("n", "<space>hd", gs.diffthis, opts)
			vim.keymap.set("n", "<space>hi", gs.toggle_signs, opts)
			vim.keymap.set("n", "<space>hb", gs.toggle_current_line_blame, opts)
			vim.keymap.set("n", "<space>hB", function()
				gs.blame_line { full = true }
			end, opts)
		end,
	},
}
