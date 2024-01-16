return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
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
			{ "<space>oo", fzf.oldfiles },
			{ "<leader><leader>", fzf.resume },
			{ "<space>gt", fzf.git_status },
			{ "<space>gb", fzf.git_bcommits },
			{ "<space>gc", fzf.git_commits },
			{
				"<leader>/",
				function()
					fzf.lgrep_curbuf {
						winopts = {
							height = 0.75,
							width = 0.75,
							preview = { vertical = "up:70%" },
						},
					}
				end,
			},
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

			{ "gr", fzf.lsp_references },
			{ "gd", fzf.lsp_definitions },
			{ "gI", fzf.lsp_implementations },
			{ "<space>d", fzf.diagnostics_workspace },
			{ "<space>sy", fzf.lsp_document_symbols },
		}
	end,
	opts = function()
		return {
			defaults = {
				preview_pager = "delta --diff-highlight --width=$FZF_PREVIEW_COLUMNS",
			},
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
		}
	end,
}
