return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = function()
		local fzf = require "fzf-lua"
		return {
			{ "<space><space>", fzf.files },
			{ "<space>gg", fzf.live_grep_glob },
			{ "<space>gs", mode = { "n" }, fzf.grep_cword },
			{ "<space>gs", mode = { "x" }, fzf.grep_visual },
			{ "<space>b", fzf.buffers },
			{ "<space>re", fzf.registers },
			{ "<space>ht", fzf.help_tags },
			{ "<space>km", fzf.keymaps },
			{ "<space>mm", fzf.marks },
			{ "<space>oo", fzf.oldfiles },
			{ "<leader><leader>", fzf.resume },
			{ "<space>gt", fzf.git_status },
			{ "<space>gb", fzf.git_bcommits },
			{ "<space>gc", fzf.git_commits },
			{ "<leader>/", fzf.lgrep_curbuf },
			{
				"<space>cc",
				function()
					fzf.files { cwd = vim.fn.expand "%:h" }
				end,
			},
			{
				"<space>cf",
				function()
					fzf.files {
						cwd = "$HOME/.config",
						prompt = "Config Files> ",
					}
				end,
			},

			{ "<space>sy", fzf.lsp_document_symbols },
		}
	end,
	opts = {
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
				["<C-f>"] = "toggle-fullscreen",
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
	},
}
