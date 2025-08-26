return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.g.lazygit_config = false
		-- In init.lua or a plugin config file
		vim.g.lazygit_floating_window_winblend = 0 -- Transparency (0 = opaque)
		vim.g.lazygit_floating_window_scaling_factor = 0.8 -- 80% of screen size
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- Rounded border
		vim.g.lazygit_floating_window_use_plenary = 1 -- Use plenary.nvim for floating window
		-- Set custom highlight groups for LazyGit floating window
		vim.api.nvim_set_hl(0, "LazyGitFloat", { bg = "#eeeeee", fg = "#4d4d4c" })
		vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = "#4271ae" })
		vim.api.nvim_set_hl(0, "LazyGitCursor", { fg = "#aaaaaa", bg = "#f5f5f5" })
	end,
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
}
