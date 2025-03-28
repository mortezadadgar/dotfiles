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

		vim.keymap.set("n", "<space><space>", fzf.files)
		vim.keymap.set("n", "<space>gg", fzf.live_grep_glob)
		vim.keymap.set("n", "<space>gs", fzf.grep_cword)
		vim.keymap.set("x", "<space>gs", fzf.grep_visual)
		vim.keymap.set("n", "<space>b", fzf.buffers)
		vim.keymap.set("n", "<space>oo", fzf.oldfiles)
		vim.keymap.set("n", "<leader><leader>", fzf.resume)
		vim.keymap.set("n", "<space>gt", fzf.git_status)
		vim.keymap.set("n", "<space>gb", fzf.git_bcommits)
		vim.keymap.set("n", "<space>gc", fzf.git_commits)
		vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf)
		vim.keymap.set("n", "z=", fzf.spell_suggest)

		vim.keymap.set("n", "<space>cc", function()
			fzf.files {
				cwd = vim.fn.expand "%:h",
			}
		end)

		vim.keymap.set("n", "<space>cf", function()
			fzf.files {
				cwd = "$HOME/.config",
				prompt = "Config Files> ",
				follow = true,
			}
		end)

		fzf.register_ui_select()
	end,
}
