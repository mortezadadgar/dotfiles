return {
	"lewis6991/gitsigns.nvim",
	enabled = false,
	opts = {
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "" },
		},
		current_line_blame_opts = {
			delay = 500,
		},
		on_attach = function(buffer)
			local gitsigns = require "gitsigns"
			local opts = { buffer = buffer }

			-- Navigation
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal { "]c", bang = true }
				else
					gitsigns.nav_hunk("next", { preview = true })
				end
			end, opts)

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal { "[c", bang = true }
				else
					gitsigns.nav_hunk("prev", { preview = true })
				end
			end, opts)

			-- Actions
			vim.keymap.set("n", "<space>hs", gitsigns.stage_hunk, opts)
			vim.keymap.set("n", "<space>hr", gitsigns.reset_hunk, opts)

			vim.keymap.set("v", "<space>hs", function()
				gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
			end, opts)

			vim.keymap.set("v", "<space>hr", function()
				gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
			end, opts)

			vim.keymap.set("n", "<space>hS", gitsigns.stage_buffer, opts)
			vim.keymap.set("n", "<space>hR", gitsigns.reset_buffer, opts)
			vim.keymap.set("n", "<space>hp", gitsigns.preview_hunk_inline, opts)

			-- Toggles
			vim.keymap.set("n", "<space>ts", gitsigns.toggle_signs, opts)

			-- Text object
			vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, opts)
		end,
	},
}
