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
		map("n", "<Space>hS", gs.stage_buffer, "Stage buffer")
		map("n", "<Space>hu", gs.undo_stage_hunk, "Undo stage hunk")
		map("n", "<Space>hR", gs.reset_buffer, "Reset buffer")
		map("n", "<Space>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<Space>hb", gs.toggle_current_line_blame, "Toggle current line blame")
		map("n", "<Space>hd", gs.diffthis, "Run diff on current buffer")
	end,
}
