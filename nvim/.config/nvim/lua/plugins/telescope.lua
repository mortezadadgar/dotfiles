local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = {
			"^node_modules/",
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
				["<C-q>"] = actions.add_to_qflist,
			},
		},
	},
	extensions = {
		file_browser = {
			grouped = true,
			dir_icon = "",
			display_stat = false,
		},
	},
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "file_browser"

vim.keymap.set("n", "<Space><Space>", builtin.find_files, { desc = "Telescope: Find all files" })
vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Telescope: Resume" })
vim.keymap.set("n", "<Space>b", builtin.buffers, { desc = "Telescope: Buffers" })
vim.keymap.set("n", "<Space>k", builtin.keymaps, { desc = "Telescope: Keymaps" })
vim.keymap.set("n", "<Space>g", builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set({ "n", "v" }, "<Space>s", builtin.grep_string, { desc = "Telescope: Grep string" })
vim.keymap.set("n", "<leader>/", builtin.oldfiles, { desc = "Telescope: Old files" })
vim.keymap.set(
	"n",
	"<space>pv",
	"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR><CR>",
	{ desc = "Telescope: File browser" }
)
