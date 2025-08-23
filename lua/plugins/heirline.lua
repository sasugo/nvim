return {
	{
		"rebelot/heirline.nvim",
		event = "UiEnter", -- Lazy-load on UiEnter for better startup performance
		dependencies = {
			"Zeioth/heirline-components.nvim",
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			local conditions = require("heirline.conditions")
			local utils = require("heirline.utils")

			-- Simple ViMode component for the statusline
			local ViMode = {
				-- get vim current mode, this information will be required by the provider
				-- and the highlight functions, so we compute it only once per component
				-- evaluation and store it as a component attribute
				init = function(self)
					self.mode = vim.fn.mode(1) -- :h mode()
				end,
				-- Now we define some dictionaries to map the output of mode() to the
				-- corresponding string and color. We can put these into `static` to compute
				-- them at initialisation time.
				static = {
					mode_names = { -- change the strings if you like it vvvvverbose!
						n = "N",
						no = "N?",
						nov = "N?",
						noV = "N?",
						["no\22"] = "N?",
						niI = "Ni",
						niR = "Nr",
						niV = "Nv",
						nt = "Nt",
						v = "V",
						vs = "Vs",
						V = "V_",
						Vs = "Vs",
						["\22"] = "^V",
						["\22s"] = "^V",
						s = "S",
						S = "S_",
						["\19"] = "^S",
						i = "I",
						ic = "Ic",
						ix = "Ix",
						R = "R",
						Rc = "Rc",
						Rx = "Rx",
						Rv = "Rv",
						Rvc = "Rv",
						Rvx = "Rv",
						c = "C",
						cv = "Ex",
						r = "...",
						rm = "M",
						["r?"] = "?",
						["!"] = "!",
						t = "T",
					},
					mode_colors = {
						n = "red",
						i = "green",
						v = "cyan",
						V = "cyan",
						["\22"] = "cyan",
						c = "orange",
						s = "purple",
						S = "purple",
						["\19"] = "purple",
						R = "orange",
						r = "orange",
						["!"] = "red",
						t = "red",
					},
				},
				-- We can now access the value of mode() that, by now, would have been
				-- computed by `init()` and use it to index our strings dictionary.
				-- note how `static` fields become just regular attributes once the
				-- component is instantiated.
				-- To be extra meticulous, we can also add some vim statusline syntax to
				-- control the padding and make sure our string is always at least 2
				-- characters long. Plus a nice Icon.
				provider = function(self)
					return "🐯%2(" .. self.mode_names[self.mode] .. "%)"
				end,
				-- Same goes for the highlight. Now the foreground will change according to the current mode.
				hl = function(self)
					local mode = self.mode:sub(1, 1) -- get only the first mode character
					return { fg = self.mode_colors[mode], bold = true }
				end,
				-- Re-evaluate the component only on ModeChanged event!
				-- Also allows the statusline to be re-evaluated when entering operator-pending mode
				update = {
					"ModeChanged",
					pattern = "*:*",
					callback = vim.schedule_wrap(function()
						vim.cmd("redrawstatus")
					end),
				},
			}

			local FileNameBlock = {
				-- let's first set up some attributes needed by this component and its children
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(0)
				end,
			}
			-- We can now define some children separately and add them later

			local FileIcon = {
				init = function(self)
					local filename = self.filename
					local extension = vim.fn.fnamemodify(filename, ":e")
					self.icon, self.icon_color =
						require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
				end,
				provider = function(self)
					return self.icon and (self.icon .. " ")
				end,
				hl = function(self)
					return { fg = self.icon_color }
				end,
			}

			local FileName = {
				provider = function(self)
					-- first, trim the pattern relative to the current directory. For other
					-- options, see :h filename-modifers
					local filename = vim.fn.fnamemodify(self.filename, ":.")
					if filename == "" then
						return "[No Name]"
					end
					-- now, if the filename would occupy more than 1/4th of the available
					-- space, we trim the file path to its initials
					-- See Flexible Components section below for dynamic truncation
					if not conditions.width_percent_below(#filename, 0.25) then
						filename = vim.fn.pathshorten(filename)
					end
					return filename
				end,
			}

			local FileFlags = {
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = "[+]",
					hl = { fg = "green" },
				},
				{
					condition = function()
						return not vim.bo.modifiable or vim.bo.readonly
					end,
					provider = "",
					hl = { fg = "orange" },
				},
			}

			-- Now, let's say that we want the filename color to change if the buffer is
			-- modified. Of course, we could do that directly using the FileName.hl field,
			-- but we'll see how easy it is to alter existing components using a "modifier"
			-- component

			local FileNameModifer = {
				hl = function()
					if vim.bo.modified then
						-- use `force` because we need to override the child's hl foreground
						return { fg = "cyan", bold = true, force = true }
					end
				end,
			}

			-- let's add the children to our FileNameBlock component
			FileNameBlock = utils.insert(
				FileNameBlock,
				FileIcon,
				utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
				FileFlags,
				{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
			)

			-- We're getting minimalist here!
			local Ruler = {
				-- %l = current line number
				-- %L = number of lines in the buffer
				-- %c = column number
				-- %P = percentage through file of displayed window
				provider = "%7(%l/%3L%):%2c %P",
			}
			-- I take no credits for this! 🦁
			local ScrollBar = {
				static = {
					sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
					-- Another variant, because the more choice the better.
					-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
				},
				provider = function(self)
					local curr_line = vim.api.nvim_win_get_cursor(0)[1]
					local lines = vim.api.nvim_buf_line_count(0)
					local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
					return string.rep(self.sbar[i], 2)
				end,
			}

			local LSPActive = {
				condition = conditions.lsp_attached,
				update = { "LspAttach", "LspDetach" },

				-- You can keep it simple,
				-- provider = " [LSP]",

				-- Or complicate things a bit and get the servers names
				provider = function()
					local names = {}
					for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						table.insert(names, server.name)
					end
					return " [" .. table.concat(names, " ") .. "]"
				end,
			}

			-- Full nerd (with icon colors and clickable elements)!
			-- works in multi window, but does not support flexible components (yet ...)
			local Navic = {
				condition = function()
					return require("nvim-navic").is_available()
				end,
				static = {
					-- create a type highlight map
					type_hl = {
						File = "Directory",
						Module = "@include",
						Namespace = "@namespace",
						Package = "@include",
						Class = "@structure",
						Method = "@method",
						Property = "@property",
						Field = "@field",
						Constructor = "@constructor",
						Enum = "@field",
						Interface = "@type",
						Function = "@function",
						Variable = "@variable",
						Constant = "@constant",
						String = "@string",
						Number = "@number",
						Boolean = "@boolean",
						Array = "@field",
						Object = "@type",
						Key = "@keyword",
						Null = "@comment",
						EnumMember = "@field",
						Struct = "@structure",
						Event = "@keyword",
						Operator = "@operator",
						TypeParameter = "@type",
					},
					-- bit operation dark magic, see below...
					enc = function(line, col, winnr)
						return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
					end,
					-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
					dec = function(c)
						local line = bit.rshift(c, 16)
						local col = bit.band(bit.rshift(c, 6), 1023)
						local winnr = bit.band(c, 63)
						return line, col, winnr
					end,
				},
				init = function(self)
					local data = require("nvim-navic").get_data() or {}
					local children = {}
					-- create a child for each level
					for i, d in ipairs(data) do
						-- encode line and column numbers into a single integer
						local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
						local child = {
							{
								provider = d.icon,
								hl = self.type_hl[d.type],
							},
							{
								-- escape `%`s (elixir) and buggy default separators
								provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
								-- highlight icon only or location name as well
								-- hl = self.type_hl[d.type],

								on_click = {
									-- pass the encoded position through minwid
									minwid = pos,
									callback = function(_, minwid)
										-- decode
										local line, col, winnr = self.dec(minwid)
										vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
									end,
									name = "heirline_navic",
								},
							},
						}
						-- add a separator only if needed
						if #data > 1 and i < #data then
							table.insert(child, {
								provider = " > ",
							})
						end
						table.insert(children, child)
					end
					-- instantiate the new child, overwriting the previous one
					self.child = self:new(children, 1)
				end,
				-- evaluate the children containing navic components
				provider = function(self)
					return self.child:eval()
				end,
				hl = { fg = "gray" },
				update = "CursorMoved",
			}

			local Git = {
				condition = function()
					return vim.b.gitsigns_status_dict ~= nil
				end,
				init = function(self)
					self.status_dict = vim.b.gitsigns_status_dict
					self.has_changes = self.status_dict.added ~= 0
						or self.status_dict.removed ~= 0
						or self.status_dict.changed ~= 0
				end,
				-- Add providers for displaying Git status
				{
					provider = function(self)
						return self.status_dict.head and " " .. self.status_dict.head .. " "
					end,
				},
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and ("+" .. count)
					end,
					hl = { fg = "green" },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and ("~" .. count)
					end,
					hl = { fg = "yellow" },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and ("-" .. count)
					end,
					hl = { fg = "red" },
				},
			}
			-- Get diagnostic sign icons
			local function get_diagnostic_sign_text(severity)
				local signs = vim.fn.sign_getdefined()
				local sign_name = "DiagnosticSign" .. severity
				local sign = vim.fn.sign_getdefined(sign_name)
				if sign and sign[1] and sign[1].text then
					return sign[1].text
				else
					local defaults = {
						Error = "E",
						Warn = "W",
						Info = "I",
						Hint = "H",
					}
					return defaults[severity] or ""
				end
			end

			local error_icon = get_diagnostic_sign_text("Error")
			local warn_icon = get_diagnostic_sign_text("Warn")
			local info_icon = get_diagnostic_sign_text("Info")
			local hint_icon = get_diagnostic_sign_text("Hint")

			-- Heirline diagnostics component
			local Diagnostics = {
				condition = conditions.lsp_diagnostics_enabled,
				update = { "DiagnosticChanged", "BufEnter" },
				static = {
					error_icon = error_icon,
					warn_icon = warn_icon,
					info_icon = info_icon,
					hint_icon = hint_icon,
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
						return count > 0 and (self.error_icon .. count .. " ")
					end,
					hl = { fg = "red" },
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
						return count > 0 and (self.warn_icon .. count .. " ")
					end,
					hl = { fg = "yellow" },
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
						return count > 0 and (self.info_icon .. count .. " ")
					end,
					hl = { fg = "blue" },
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
						return count > 0 and (self.hint_icon .. count .. " ")
					end,
					hl = { fg = "green" },
				},
			}

			local WorkDir = {
				provider = function()
					local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
					local cwd = vim.fn.getcwd(0)
					cwd = vim.fn.fnamemodify(cwd, ":~")
					if not conditions.width_percent_below(#cwd, 0.25) then
						cwd = vim.fn.pathshorten(cwd)
					end
					local trail = cwd:sub(-1) == "/" and "" or "/"
					return icon .. cwd .. trail
				end,
				hl = { fg = "blue", bold = true },
			}

			-- Add to your statusline or winbar
			local StatusLine = {
				ViMode,
				{ provider = " | " },
				WorkDir,
				{ provider = " | " },
				Git,
				{ provider = " | " },
				FileNameBlock,
				{ provider = " | " },
				LSPActive,
				{ provider = " | " },
				Diagnostics,
				{ provider = "%=" }, -- Right-align what follows
				Ruler,
				{ provider = " " },
				ScrollBar,
			}

			local Winbar = {
				Navic,
			}

			local latte = require("catppuccin.palettes").get_palette("latte")

			-- Setup heirline
			require("heirline").setup({
				statusline = StatusLine,
				winbar = Winbar,
				opts = {
					colors = latte,
				},
			})
		end,
	},
}
