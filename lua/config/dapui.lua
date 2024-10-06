local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
	return
end

local M = {}
M.setup = function()
	local opts = { noremap = true }
	local keymap = vim.api.nvim_set_keymap
    vim.keymap.set('n', '<leader><F3>', dapui.toggle, {})
    vim.keymap.set('n', '<leader><F1>', dapui.open, {})
	dapui.setup()
end

return M
