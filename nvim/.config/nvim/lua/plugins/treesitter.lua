return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
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
				"sql",
			},

			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},
			textobjects = {
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
			}
		}
	end,
}
