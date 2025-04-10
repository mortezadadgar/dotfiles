-- make it a command and use lsp root dir to find project
local workspace_path = vim.fn.getcwd()
local project_name = vim.fn.fnamemodify(workspace_path, ":t")
local shada_dir = vim.fn.stdpath "data" .. "/myshada/" .. project_name

if vim.fn.isdirectory(shada_dir) == 0 then
	vim.fn.mkdir(shada_dir, "p")
end

vim.opt.shadafile = shada_dir .. "/" .. vim.fn.sha256(workspace_path):sub(1, 8) .. ".shada"
