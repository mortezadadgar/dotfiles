vim.pack.add {
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
}

require("gitsigns").setup {
	signcolumn = true,
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(buffer)
		local gitsigns = require "gitsigns"

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = "Git: " .. desc })
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal { "]c", bang = true }
			else
				gitsigns.nav_hunk("next", { preview = true })
			end
		end, "Next hunk")

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal { "[c", bang = true }
			else
				gitsigns.nav_hunk("prev", { preview = true })
			end
		end, "previous hunk")

		-- Actions
		map("n", "ghh", gitsigns.stage_hunk, "stage hunk")
		map("n", "ghH", gitsigns.reset_hunk, "reset hunk")

		map("v", "ghh", function()
			gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
		end, "stage hunk")

		map("v", "ghH", function()
			gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
		end, "reset hunk")

		-- View
		map("n", "ghd", gitsigns.diffthis, "diff this")
		map("n", "ghb", gitsigns.blame, "blame")
		map("n", "ghp", gitsigns.preview_hunk, "preview hunk")

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk, "stage hung")
	end,
}
