return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = false,
	config = function()
		local kanagawa_dragon = {
			normal = {
				a = { fg = "#1F1F28", bg = "#D4A017", gui = "bold" }, -- roninYellow on sumiInk1
				b = { fg = "#DCD7BA", bg = "#2A2A37" }, -- fujiWhite on sumiInk2
				c = { fg = "#727169", bg = "#1F1F28" }, -- fujiGray on sumiInk1
			},
			insert = {
				a = { fg = "#1F1F28", bg = "#98BB6C", gui = "bold" }, -- springGreen on sumiInk1
				b = { fg = "#DCD7BA", bg = "#2A2A37" }, -- fujiWhite on sumiInk2
				c = { fg = "#727169", bg = "#1F1F28" }, -- fujiGray on sumiInk1
			},
			visual = {
				a = { fg = "#1F1F28", bg = "#FFA066", gui = "bold" }, -- surimiOrange on sumiInk1
				b = { fg = "#DCD7BA", bg = "#2A2A37" }, -- fujiWhite on sumiInk2
				c = { fg = "#727169", bg = "#1F1F28" }, -- fujiGray on sumiInk1
			},
			replace = {
				a = { fg = "#1F1F28", bg = "#E82424", gui = "bold" }, -- samuraiRed on sumiInk1
				b = { fg = "#DCD7BA", bg = "#2A2A37" }, -- fujiWhite on sumiInk2
				c = { fg = "#727169", bg = "#1F1F28" }, -- fujiGray on sumiInk1
			},
			command = {
				a = { fg = "#1F1F28", bg = "#7E9CD8", gui = "bold" }, -- dragonBlue on sumiInk1
				b = { fg = "#DCD7BA", bg = "#2A2A37" }, -- fujiWhite on sumiInk2
				c = { fg = "#727169", bg = "#1F1F28" }, -- fujiGray on sumiInk1
			},
			inactive = {
				a = { fg = "#727169", bg = "#16161D", gui = "bold" }, -- fujiGray on sumiInk0
				b = { fg = "#727169", bg = "#1F1F28" }, -- fujiGray on sumiInk1
				c = { fg = "#54546D", bg = "#1F1F28" }, -- sumiInk4 on sumiInk1
			},
		}
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true, -- Optional: single statusline for all windows,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = "✖ ", warn = "⚠ ", info = "ℹ ", hint = "➤ " },
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- Show relative path
						symbols = { modified = "[+]", readonly = "[-]" },
					},
					{
						-- Custom nvim-navic component
						function()
							local navic = require("nvim-navic")
							if navic.is_available() then
								local location = navic.get_location({ depth_limit = 3 }) -- Reinforce 2-level limit
								return location
							end
							return ""
						end,
						cond = function()
							return require("nvim-navic").is_available()
						end,
					},
				},
				lualine_x = {
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
