return {
	{
		"echasnovski/mini.files",
		config = function()
			local minifiles = require "mini.files"

			minifiles.setup {
				windows = {
					width_preview = 70,
				},
			}

			local toggle_preview = function()
				minifiles.config.windows.preview = not minifiles.config.windows.preview
				minifiles.refresh {}
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "<C-p>", toggle_preview, { buffer = buf_id })
				end,
			})

			vim.keymap.set("n", "-", function()
				if not require("mini.files").close() then
					local bufname = vim.api.nvim_buf_get_name(0)
					local path = vim.fn.fnamemodify(bufname, ":p")

					-- Noop if the buffer isn't valid.
					if path and vim.uv.fs_stat(path) then
						require("mini.files").open(bufname)
					end
				end
			end)
		end,
	},
}
