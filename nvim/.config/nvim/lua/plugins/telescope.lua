local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = {
			"%.svg",
			"%.ttf",
			"%.jpg",
			"%.png",
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
				["<C-q>"] = actions.smart_add_to_qflist,
			},
		},
	},
}

require("telescope").load_extension "fzf"

vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Telescope: Resume" })
vim.keymap.set("n", "<Space>lg", builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set({ "n", "v" }, "<Space>gs", builtin.grep_string, { desc = "Telescope: Grep string" })
vim.keymap.set("n", "<Space><Space>", builtin.find_files, { desc = "Telescope: Config files" })

local list_buffers = function()
	builtin.buffers { sort_lastused = true, ignore_current_buffer = true }
end
vim.keymap.set("n", "<Space>b", list_buffers, { desc = "Telescope: Buffers" })

local find_config_files = function()
	builtin.find_files {
		prompt_title = "~ config files ~",
		shorten_path = false,
		cwd = "~/.config/",
		hidden = true,
		follow = true,

		layout_strategy = "horizontal",
		previewer = false,
	}
end
vim.keymap.set("n", "<Space>cf", find_config_files, { desc = "Telescope: Config files" })

local fuzzy_find_curbuf = function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown {
		layout_config = { width = 90 },
		borderchars = {
			prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
		},
		previewer = false,
	})
end
vim.keymap.set("n", "<leader>/", fuzzy_find_curbuf, { desc = "Fuzzily search in current buffer" })
