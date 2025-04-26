return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"echasnovski/mini.icons",
	},
	config = function()
		local delta_preview = "delta --width=$COLUMNS --syntax-theme base16 --diff-highlight"
		require("fzf-lua").setup {
			-- keep the fzf process running in background, allow for a richer `:FzfLua resume`
			"hide",

			fzf_opts = {
				["--layout"] = "default",
				["--no-scrollbar"] = "",
				["--history"] = vim.fn.stdpath "data" .. "/fzf-lua-history",
			},
			previewers = {
				git_diff = {
					pager = delta_preview,
				},
				builtin = {
					extensions = {
						["png"] = { "ueberzug" },
						["jpg"] = { "ueberzug" },
						["jpeg"] = { "ueberzug" },
						["webp"] = { "ueberzug" },
						["svg"] = { "chafa" },
					},
					ueberzug_scaler = "cover",
				},
			},
			winopts = {
				preview = {
					scrollbar = false,
				},
			},
			files = {
				cwd_prompt = false,
				prompt = "Files> ",
				actions = {
					["ctrl-y"] = {
						fn = function(selected)
							if #selected > 0 then
								local path = vim.split(selected[1], " ")[2]
								vim.fn.setreg([[+]], path)
							end
						end,
						header = "Copy Path",
						exec_silent = true,
					},
				},
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
			lsp = {
				includeDeclaration = false,
			},
			oldfiles = {
				cwd_only = true,
			},
			buffers = {
				cwd_only = true,
				ignore_current_buffer = true,
			},
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
					["<C-e>"] = "toggle-preview",
				},
				fzf = {
					["ctrl-e"] = "toggle-preview",
					["ctrl-d"] = "preview-page-down",
					["ctrl-u"] = "preview-page-up",
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
		vim.keymap.set("n", "<space>o", fzf.oldfiles, { desc = "FZF: Oldfiles" })
		vim.keymap.set("n", "<space>gt", fzf.git_status, { desc = "FZF: Git Status" })
		vim.keymap.set("n", "<space>?", fzf.help_tags, { desc = "FZF: Help Tags" })
		vim.keymap.set("n", "<space>tb", fzf.tmux_buffers, { desc = "FZF: Tmux buffers" })
		vim.keymap.set("n", "<leader><leader>", fzf.resume, { desc = "FZF: Resume" })
		vim.keymap.set("n", "<leader>/", fzf.grep_curbuf, { desc = "FZF: grep current buffer" })
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

		vim.keymap.set("ca", "F", "FzfLua", { desc = "Alias FzfLua to F" })
	end,
}
