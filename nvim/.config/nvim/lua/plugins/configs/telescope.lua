local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local map = vim.keymap.set

require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = { "%.svg", "%.jpg", "%.png", "node_modules" },
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
}

require("telescope").load_extension "fzf"

-- fuzzy finder
map("n", "<Space><Space>", builtin.find_files, { desc = "Telescope: find files" })
map("n", "<leader><leader>", builtin.resume, { desc = "Telescope: Resume" })
map("n", "<Space>b", builtin.buffers, { desc = "Telescope: Buffers" })
map("n", "<Space>k", builtin.keymaps, { desc = "Telescope: Keymaps" })
map("n", "<Space>g", builtin.live_grep, { desc = "Telescope: Live grep" })
map("n", "<Space>v", builtin.grep_string, { desc = "Telescope: Grep string" })
map("n", "<Space>o", builtin.oldfiles, { desc = "Telescope: Old files" })
