local M = {}

M.setup = function()
	local markview = require("markview")
	local presets = require("markview.presets")

	markview.setup({
		headings = {
			enable = true,

			heading_1 = {
				style = "label",

				padding_left = " ",
				padding_right = " ",

				hl = "MarkviewHeading1",
			},
		},
		Checkboxes = {
			enable = true,

			checked = {
				text = "✔",
				hl = "TabLineSel",
			},
			unchecked = {},
			pending = {},
		},
	})
end

return M
