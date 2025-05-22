return {
	"echasnovski/mini.files",
	version = "*",
	config = function()
		local minifiles = require "mini.files"
		minifiles.setup {
			windows = {
				preview = true,
				width_preview = 80,
			},
		}

		local map_split = function(buf_id, lhs, direction)
			local rhs = function()
				-- Make new window and set it as target
				local cur_target = minifiles.get_explorer_state().target_window
				local new_target = vim.api.nvim_win_call(cur_target, function()
					vim.cmd(direction .. " split")
					return vim.api.nvim_get_current_win()
				end)

				minifiles.set_target_window(new_target)
			end

			local desc = "Split " .. direction
			vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				-- Tweak keys to your liking
				map_split(buf_id, "<C-s>", "belowright horizontal")
				map_split(buf_id, "<C-v>", "belowright vertical")
				map_split(buf_id, "<C-t>", "tab")
			end,
		})

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
