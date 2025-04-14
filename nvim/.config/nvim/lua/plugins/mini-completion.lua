return {
	"echasnovski/mini.completion",
	dependencies = {
		{
			"echasnovski/mini.snippets",
			opts = true,
		},
	},
	opts = {
		window = {
			signature = { border = "single" },
		},
		fallback_action = "<C-x><C-n>",
	},

	init = function()
		local imap_expr = function(lhs, rhs)
			vim.keymap.set("i", lhs, rhs, { expr = true })
		end

		imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
		imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

		local keys = {
			["cr"] = vim.keycode "<CR>",
			["ctrl-y"] = vim.keycode "<C-y>",
			["ctrl-y_cr"] = vim.keycode "<C-y><CR>",
		}

		_G.cr_action = function()
			if vim.fn.pumvisible() ~= 0 then
				local item_selected = vim.fn.complete_info()["selected"] ~= -1
				return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
			else
				return keys["cr"]
			end
		end

		vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
	end,
}
