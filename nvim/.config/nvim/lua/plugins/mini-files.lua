return {
	"echasnovski/mini.files",
	enabled = false,
	config = function()
		local minifiles = require "mini.files"

		minifiles.setup {
			windows = {
				preview = true,
				width_preview = 70,
			},
		}

		vim.keymap.set("n", "-", function()
			if not minifiles.close() then
				local bufname = vim.api.nvim_buf_get_name(0)
				local path = vim.fn.fnamemodify(bufname, ":p")

				-- Noop if the buffer isn't valid.
				if path and vim.uv.fs_stat(path) then
					minifiles.open(bufname)
				end
			end
		end)
	end,
}
