return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"echasnovski/mini.icons",
	},
	config = function()
		local delta_preview = "delta --width=$COLUMNS --syntax-theme base16 --diff-highlight"
		require("fzf-lua").setup {
			fzf_opts = {
				["--layout"] = "default",
				["--no-scrollbar"] = "",
				["--history"] = vim.fn.stdpath "data" .. "/fzf-lua-history",
			},
			previewers = {
				git_diff = {
					pager = delta_preview,
				},
			},
			winopts = {
				border = "single",
				preview = {
					scrollbar = false,
					-- wrap = true,
				},
			},
			files = {
				cwd_prompt = false,
				prompt = "Files> ",
			},
			git = {
				commits = {
					preview_pager = delta_preview,
				},
				bcommits = {
					preview_pager = delta_preview,
				},
				stash = {
					preview_pager = delta_preview,
				},
				blame = {
					preview_pager = delta_preview,
				},
			},
			actions = {
				files = {
					true,
					["ctrl-y"] = {
						fn = function(selected)
							local path = vim.split(selected[1], " ")[2]
							vim.fn.setreg([[+]], path)
						end,
						header = ":: to Copy Path",
						exec_silent = true,
					},
				},
			},
			lsp = {
				includeDeclaration = false,
			},
			oldfiles = {
				cwd_only = true,
			},
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-q"] = "select-all+accept",
					["ctrl-j"] = "next-history",
					["ctrl-k"] = "previous-history",
					["ctrl-n"] = "down",
					["ctrl-p"] = "up",
				},
			},
		}

		local fzf = require "fzf-lua"

		vim.keymap.set("n", "<space><space>", fzf.files, { desc = "FZF: Find Files" })
		vim.keymap.set("n", "<space>gg", fzf.live_grep_glob, { desc = "FZF: Live grep" })
		vim.keymap.set("n", "<space>gs", fzf.grep_cword, { desc = "FZF: Grep Word under cursor" })
		vim.keymap.set("x", "<space>gs", fzf.grep_visual, { desc = "FZF: Grep Word under cursor" })
		vim.keymap.set("n", "<space>b", fzf.buffers, { desc = "FZF: buffers" })
		vim.keymap.set("n", "<space>oo", fzf.oldfiles, { desc = "FZF: Oldfiles" })
		vim.keymap.set("n", "<leader><leader>", fzf.resume, { desc = "FZF: Resume" })
		vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf, { desc = "FZF: grep current buffer" })
		vim.keymap.set("n", "z=", fzf.spell_suggest, { desc = "FZF: Spell Suggest" })

		vim.keymap.set("n", "<space>cc", function()
			fzf.files {
				cwd = vim.fn.expand "%:h",
			}
		end, { desc = "FZF: Find Files current buffer directory" })

		vim.keymap.set("n", "<space>cf", function()
			fzf.files {
				cwd = "$HOME/.config",
				prompt = "Config Files> ",
				follow = true,
			}
		end, { desc = "FZF: Find Config Files" })

		fzf.register_ui_select()
	end,
}
