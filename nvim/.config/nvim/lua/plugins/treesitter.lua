vim.pack.add {
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
}

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "vim.pack hook",
	group = vim.api.nvim_create_augroup("VimPackHook", {}),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.cmd ":TSUpdate"
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "TreesitterAutoInstall",
	group = vim.api.nvim_create_augroup("TreesitterAutoInstall", {}),
	callback = function(ev)
		local ft = ev.match
		local buf = ev.buf

		if vim.bo[buf].buftype == "nofile" then
			return
		end

		local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
		if not ok then
			return
		end

		local parser = require("nvim-treesitter.parsers")[ft]
		if not parser then
			return -- no parser available
		end

		require("nvim-treesitter").install({ lang }):await(function()
			vim.treesitter.start(buf, lang)
		end)
	end,
})
