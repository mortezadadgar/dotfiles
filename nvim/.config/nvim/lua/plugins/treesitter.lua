return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				max_lines = 1,
				min_window_height = 20,
				trim_scope = "inner",
			},
		},
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
	},
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"markdown_inline",
			},

			ignore_install = {
				"ini",
				"vim",
			},

			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = false,
					include_surrounding_whitespace = true,
					keymaps = {
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["aC"] = "@class.outer",
						["iC"] = "@class.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_end = {
						["]f"] = "@function.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]a"] = "@parameter.inner",
					},
					swap_previous = {
						["[a"] = "@parameter.inner",
					},
				},
			},
		}
	end,
}
