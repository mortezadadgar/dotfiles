return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = function()
		local buitlin = require "telescope.builtin"
		return {
			{ "<leader><leader>", buitlin.resume, desc = "Telescope: Resume" },
			{ "<space>gg", buitlin.live_grep, desc = "Telescope: Live grep" },
			{ "<space>gs", mode = { "n", "x" }, buitlin.grep_string, desc = "Telescope: Grep string" },
			{ "<space>gf", buitlin.git_files, desc = "Telescope: Git files" },
			{ "<space>re", buitlin.registers, desc = "Telescope: Registers" },
			{ "<space>ht", buitlin.help_tags, desc = "Telescope: Help tags" },
			{ "<space>km", buitlin.keymaps, desc = "Telescope: Keymaps" },
			{ "<space>oo", buitlin.oldfiles, desc = "Telescope: OldFiles" },
			{ "<space>mm", buitlin.marks, desc = "Telescope: Marks" },
			{ "<space><space>", buitlin.find_files, desc = "Telescope: Find files" },
			{
				"<space>b",
				function()
					buitlin.buffers { sort_mru = true, ignore_current_buffer = true }
				end,
				desc = "Telescope: Buffers",
			},
			{
				"<leader>/",
				buitlin.current_buffer_fuzzy_find,
				desc = "Telescope: Fuzzily search in current buffer",
			},
			{
				"<space>cc",
				function()
					builtin.find_files {
						prompt_title = "Current Buffer Files",
						cwd = utils.buffer_dir(),
						hidden = true,
					}
				end,
				{ desc = "Telescope: Find current buffer files" },
			},

			-- LSP pickers
			{ "gr", buitlin.lsp_references, desc = "Telescope: List References" },
			{ "gd", buitlin.lsp_definitions, desc = "Telescope: Goto definition" },
			{ "gI", buitlin.lsp_implementations, desc = "Telescope: List Implementations" },
			{ "<space>sy", buitlin.lsp_document_symbols, desc = "Telescope: Documents symbols" },
			{ "<space>d", buitlin.diagnostics, desc = "Telescope: List Diagnostics" },
		}
	end,
	cmd = "Telescope",
	config = function()
		local actions = require "telescope.actions"
		require("telescope").setup {
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
						["<CR>"] = actions.select_default + actions.center,
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

		require("telescope").load_extension "fzf"
	end,
}
