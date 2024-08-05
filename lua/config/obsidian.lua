local M = {}

M.setup = function()
	local obsidian = require("obsidian")
	obsidian.setup({
		workspaces = {
			{
				name = "personal",
				path = "~/vaults/personal",
			},
			{
				name = "work",
				path = "~/vaults/siwel",
			},
		},
	})
end

return M
