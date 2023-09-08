local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = {
			"%.svg",
			"%.jpg",
			"%.png",
			"node_modules",
			".git",
			".cache",
		},
		layout_strategy = "flex",
		layout_config = {
			flex = {
				flip_columns = 120,
			},
		},
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

vim.keymap.set("n", "<Space><Space>", function()
	builtin.find_files { hidden = true }
end, { desc = "Telescope: Find all files" })
vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Telescope: Resume" })
vim.keymap.set("n", "<Space>b", builtin.buffers, { desc = "Telescope: Buffers" })
vim.keymap.set("n", "<Space>k", builtin.keymaps, { desc = "Telescope: Keymaps" })
vim.keymap.set("n", "<Space>g", builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set("n", "<Space>v", builtin.grep_string, { desc = "Telescope: Grep string" })
vim.keymap.set("n", "<Space>o", builtin.oldfiles, { desc = "Telescope: Old files" })
