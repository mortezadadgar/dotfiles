require("gitsigns").setup {
	signcolumn = false,
	numhl = true,

	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, desc)
			if desc then
				desc = "gitsigns: " .. desc
			end
			vim.keymap.set(mode, l, r, { desc = desc, buffer = bufnr })
		end

		-- Navigation
		map("n", "]c", gs.next_hunk, "Next hunk")
		map("n", "[c", gs.prev_hunk, "Previous hunk")

		-- Actions
		map("n", "<Space>hs", gs.stage_hunk, "Stage hunk")
		map("n", "<Space>hr", gs.reset_hunk, "Reset hank")
		map("v", "<Space>hs", function()
			gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
		end, "Stage hunk")
		map("v", "<Space>hr", function()
			gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
		end, "Reset hank")
		map("n", "<Space>hS", gs.stage_buffer, "Stage buffer")
		map("n", "<Space>hu", gs.undo_stage_hunk, "Undo stage hunk")
		map("n", "<Space>hR", gs.reset_buffer, "Reset buffer")
		map("n", "<Space>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<Space>hb", function()
			gs.blame_line { full = true }
		end, "Blame current line")
		map("n", "<Space>tb", gs.toggle_current_line_blame, "Toggle current line blame")
		map("n", "<Space>hd", gs.diffthis, "Diffthis")
		map("n", "<Space>hD", function()
			gs.diffthis "~"
		end, "Diffthis on current base")

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select textobject hunk")
	end,
}
