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

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = "Gitsigns: " .. desc })
			end

			map("n", "]c", gs.next_hunk, "next hunk")
			map("n", "[c", gs.prev_hunk, "previous hunk")
			map("n", "<space>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<space>hr", gs.reset_hunk, "Reset hunk")
			map("n", "<space>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<space>hu", gs.undo_stage_hunk, "Undo stagged hunk")
			map("n", "<space>hR", gs.reset_buffer, "Reset buffer")
			map("n", "<space>hN", gs.reset_buffer_index, "Reset buffer in the index")
			map("n", "<space>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<space>hd", gs.diffthis, "diff buffer")
			map("n", "<space>hi", gs.toggle_signs, "Toggle git signs")
			map("n", "<space>hB", function()
				gs.blame_line { full = true }
			end, "Toggle full blame current line")
			map("n", "<space>hb", gs.toggle_current_line_blame, "Toggle blame current line")
		end,
	},
}
