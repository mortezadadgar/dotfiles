return {
	"nvim-treesitter/nvim-treesitter",
	-- version = "*", too old
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		enabled = false,
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"markdown_inline",
			},

			auto_install = true,

			highlight = {
				enable = true,
				disable = { "tmux" },
			},

			-- TODO: buggy c switch-case statements
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
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_end = {
						["]]"] = "@function.outer",
					},
					goto_previous_start = {
						["[["] = "@function.outer",
					},
				},
			},
		}
	end,
}
