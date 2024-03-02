return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local fzf = require "fzf-lua"
		vim.keymap.set("n", "<space><space>", fzf.files)
		vim.keymap.set("n", "<space>gg", fzf.live_grep_glob)
		vim.keymap.set("n", "<space>gs", fzf.grep_cword)
		vim.keymap.set("x", "<space>gs", fzf.grep_visual)
		vim.keymap.set("n", "<space>b", fzf.buffers)
		vim.keymap.set("n", "<space>re", fzf.registers)
		vim.keymap.set("n", "<space>ht", fzf.help_tags)
		vim.keymap.set("n", "<space>km", fzf.keymaps)
		vim.keymap.set("n", "<space>mm", fzf.marks)
		vim.keymap.set("n", "<space>oo", fzf.oldfiles)
		vim.keymap.set("n", "<leader><leader>", fzf.resume)
		vim.keymap.set("n", "<space>gt", fzf.git_status)
		vim.keymap.set("n", "<space>gb", fzf.git_bcommits)
		vim.keymap.set("n", "<space>gc", fzf.git_commits)
		vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf)

		vim.keymap.set("n", "<space>cc", function()
			fzf.files {
				cwd = vim.fn.expand "%:h",
			}
		end)
		vim.keymap.set("n", "<space>cf", function()
			fzf.files {
				cwd = "$HOME/.config",
				prompt = "Config Files> ",
			}
		end)

		require("fzf-lua").setup {
			fzf_opts = {
				["--layout"] = "default",
				["--no-scrollbar"] = "",
			},
			winopts = {
				border = "single",
				preview = {
					scrollbar = false,
				},
			},
			files = {
				cwd_prompt = false,
				prompt = "Files> ",
			},
			lsp = {
				jump_to_single_result = true,
				includeDeclaration = false,
			},
			keymap = {
				builtin = {
					["<C-e>"] = "toggle-preview",
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-e"] = "toggle-preview",
					["ctrl-d"] = "preview-page-down",
					["ctrl-u"] = "preview-page-up",
					["ctrl-q"] = "select-all+accept",
					["ctrl-a"] = "toggle-all",
				},
			},
		}
	end,
}
