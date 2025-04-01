return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"markdown_inline",
			},

			ignore_install = {
				"ini",
				"vim",
				"sql",
				"tmux",
			},

			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},
		}

		require("nvim-treesitter.configs").setup {
			textobjects = {
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				select = {
					enable = true,
					keymaps = {
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
		}
	end,
}
