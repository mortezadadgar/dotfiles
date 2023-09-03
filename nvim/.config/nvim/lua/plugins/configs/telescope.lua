local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

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

vim.keymap.set("n", "<Space><Space>", builtin.find_files, { desc = "Telescope: find files" })
vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Telescope: Resume" })
vim.keymap.set("n", "<Space>b", builtin.buffers, { desc = "Telescope: Buffers" })
vim.keymap.set("n", "<Space>k", builtin.keymaps, { desc = "Telescope: Keymaps" })
vim.keymap.set("n", "<Space>g", builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set("n", "<Space>v", builtin.grep_string, { desc = "Telescope: Grep string" })
vim.keymap.set("n", "<Space>o", builtin.oldfiles, { desc = "Telescope: Old files" })
-- vim.keymap.set("n", "<Space>p", builtin.git_files, { desc = "Telescope: Git files" })
