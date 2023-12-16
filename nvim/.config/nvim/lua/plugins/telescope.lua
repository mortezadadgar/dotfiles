return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"fdschmidt93/telescope-egrepify.nvim",
	},
	config = function()
		local actions = require "telescope.actions"
		local builtin = require "telescope.builtin"
		local telescope = require "telescope"

		telescope.setup {
			defaults = {
				prompt_prefix = "  ",
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				file_ignore_patterns = {
					"^.git/",
					"^node_modules/",
				},
				dynamic_preview_title = true,
				layout_strategy = "flex",
				layout_config = {
					flex = {
						flip_columns = 120,
					},
				},
				mappings = {
					i = {
						["<Esc>"] = actions.close,
						["<C-o>"] = function()
							---@diagnostic disable-next-line: redundant-return
							return
						end,
						["<C-j>"] = actions.cycle_history_next,
						["<C-k>"] = actions.cycle_history_prev,
					},
				},
			},
		}

		telescope.load_extension "fzf"
		telescope.load_extension "egrepify"

		vim.keymap.set("n", "<leader><leader>", builtin.resume)
		vim.keymap.set("n", "<space>gg", "<cmd>Telescope egrepify<CR>")
		vim.keymap.set({ "n", "x" }, "<space>gs", builtin.grep_string)
		vim.keymap.set("n", "<space>gf", builtin.git_files)
		vim.keymap.set("n", "<space>b", builtin.buffers)
		vim.keymap.set("n", "<space>re", builtin.registers)
		vim.keymap.set("n", "<space>ht", builtin.help_tags)
		vim.keymap.set("n", "<space>km", builtin.keymaps)
		vim.keymap.set("n", "<space>oo", builtin.oldfiles)
		vim.keymap.set("n", "<space><space>", builtin.find_files)
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

		local find_curfiles = function()
			builtin.find_files {
				prompt_title = "Current Buffer Files",
				cwd = vim.fn.expand "%:p:h",
				hidden = true,
			}
		end
		vim.keymap.set("n", "<space>cc", find_curfiles)

		local find_config_files = function()
			builtin.find_files {
				prompt_title = "Config Files",
				cwd = "~/.config/",
				hidden = true,
				follow = true,
			}
		end
		vim.keymap.set("n", "<space>cf", find_config_files)
	end,
}
