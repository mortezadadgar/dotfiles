local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"
local utils = require "telescope.utils"

require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = {
			"%.svg",
			"%.ttf",
			"%.jpg",
			"%.png",
			"^.git/",
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
			},
		},
	},
}

require("telescope").load_extension "fzf"

vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Telescope: Resume" })
vim.keymap.set("n", "<space>gg", builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set({ "n", "v" }, "<space>gs", builtin.grep_string, { desc = "Telescope: Grep string" })
vim.keymap.set("n", "<space>gf", builtin.git_files, { desc = "Telescope: Git files" })
vim.keymap.set("n", "<space>b", builtin.buffers, { desc = "Telescope: Buffers" })

local find_files = function()
	builtin.find_files { hidden = true }
end
vim.keymap.set("n", "<space><space>", find_files, { desc = "Telescope: Find files" })

local find_curfiles = function()
	builtin.find_files {
		prompt_title = "Current Buffer Files",
		cwd = utils.buffer_dir(),
		hidden = true,
	}
end
vim.keymap.set("n", "<space>cc", find_curfiles, { desc = "Telescope: Find current buffer files" })

local find_config_files = function()
	builtin.find_files {
		prompt_title = "Config Files",
		shorten_path = false,
		cwd = "~/.config/",
		hidden = true,
		follow = true,
	}
end
vim.keymap.set("n", "<space>cf", find_config_files, { desc = "Telescope: Config files" })

local fuzzy_find_curbuf = function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown {
		layout_config = { width = 90, height = 20 },
		borderchars = {
			prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
		},
		previewer = false,
	})
end
vim.keymap.set("n", "<leader>/", fuzzy_find_curbuf, { desc = "Fuzzily search in current buffer" })
