return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"fdschmidt93/telescope-egrepify.nvim",
	},
	keys = function()
		local builtin = require "telescope.builtin"
		return {
			{ "<leader><leader>", builtin.resume, desc = "Telescope: Resume" },
			{ "<space>gg", require("telescope").extensions.egrepify.egrepify, desc = "Telescope: Live grep" },
			{ "<space>gs", mode = { "n", "x" }, builtin.grep_string, desc = "Telescope: Grep string" },
			{ "<space>gf", builtin.git_files, desc = "Telescope: Git files" },
			{ "<space>re", builtin.registers, desc = "Telescope: Registers" },
			{ "<space>ht", builtin.help_tags, desc = "Telescope: Help tags" },
			{ "<space>km", builtin.keymaps, desc = "Telescope: Keymaps" },
			{ "<space>oo", builtin.oldfiles, desc = "Telescope: OldFiles" },
			{ "<space>mm", builtin.marks, desc = "Telescope: Marks" },
			{ "<space><space>", builtin.find_files, desc = "Telescope: Find files" },
			{
				"<space>b",
				function()
					builtin.buffers { sort_mru = true, ignore_current_buffer = true }
				end,
				desc = "Telescope: Buffers",
			},
			{
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				desc = "Telescope: Fuzzily search in current buffer",
			},
			{
				"<space>cc",
				function()
					builtin.find_files {
						prompt_title = "Current Buffer Files",
						cwd = require("telescope.utils").buffer_dir(),
						hidden = true,
					}
				end,
				{ desc = "Telescope: Find current buffer files" },
			},

			-- LSP pickers
			{ "gr", builtin.lsp_references, desc = "Telescope: List References" },
			{ "gd", builtin.lsp_definitions, desc = "Telescope: Goto definition" },
			{ "gI", builtin.lsp_implementations, desc = "Telescope: List Implementations" },
			{ "<space>sy", builtin.lsp_document_symbols, desc = "Telescope: Documents symbols" },
			{ "<space>d", builtin.diagnostics, desc = "Telescope: List Diagnostics" },
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
		require("telescope").load_extension "egrepify"
	end,
}
