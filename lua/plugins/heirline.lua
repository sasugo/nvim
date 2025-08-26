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
			-- PaperColor-inspired color object for heirline.nvim
			local colors = {
				-- Background and foreground
				bg = "#eeeeee", -- PaperColor light background
				fg = "#4d4d4c", -- PaperColor foreground
				cursor = "#aaaaaa", -- Cursor color

				-- Syntax-like colors for statusline components
				red = "#d7005f", -- Errors, deletions
				green = "#718c00", -- Success, additions
				yellow = "#d75f00", -- Warnings, changes
				blue = "#4271ae", -- Normal mode, info
				purple = "#8959a8", -- Insert mode
				cyan = "#3e999f", -- Visual mode
				light_cyan = "#34e2e2", -- Command mode
				gray = "#969694", -- Inactive components
				light_gray = "#f5f5f5", -- Subtle highlights
				dark_gray = "#1c1c1c", -- Borders, separators

				-- Mode-specific colors (mimicking PaperColor's vibrant highlights)
				n = "#4271ae", -- Blue for normal mode
				i = "#8959a8", -- Purple for insert mode
				v = "#3e999f", -- Cyan for visual mode
				R = "#d7005f", -- Red for replace mode
				c = "#34e2e2", -- Light cyan for command mode
				inactive = "#969694", -- Gray for inactive windows

				-- Diagnostics (aligned with PaperColor’s diagnostic colors)
				error = "#d7005f",
				warn = "#d75f00",
				info = "#4271ae",
				hint = "#3e999f",

				-- Filetype or other UI elements
				directory = "#718c00", -- Green for directories
				modified = "#d75f00", -- Yellow for modified files
			}

			require("heirline").load_colors(colors)

			local conditions = require("heirline.conditions")
			local utils = require("heirline.utils")

			-- Simple ViMode component for the statusline
			local ViMode = {
				-- get vim current mode, this information will be required by the provider
				-- and the highlight functions, so we compute it only once per component
				-- evaluation and store it as a component attribute
				init = function(self)
					-- self.mode = vim.fn.mode(1) -- :h mode()
					self.mode = vim.api.nvim_get_mode().mode
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
					return " 🐯%2(" .. self.mode_names[self.mode] .. "%) "
				end,
				-- Same goes for the highlight. Now the foreground will change according to the current mode.
				hl = function(self)
					-- local mode = self.mode:sub(1, 1) -- get only the first mode character
					return { fg = "bg", bg = colors[self.mode] or colors.normal, bold = true }
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
					return self.icon and (" " .. self.icon .. " ")
				end,
				hl = function(self)
					return { fg = self.icon_color, bg = "bg" }
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
					return filename .. " "
				end,
				hl = { fg = "fg", bg = "bg", bold = true },
			}

			local FileFlags = {
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = "[+] ",
					hl = { fg = "green", bg = "bg", bold = true },
				},
				{
					condition = function()
						return not vim.bo.modifiable or vim.bo.readonly
					end,
					provider = " ",
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
				FileName, -- a new table where FileName is a child of FileNameModifier
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
				hl = { bold = true, fg = "fg", bg = "bg" },
			}
			-- I take no credits for this! 🦁
			local ScrollBar = {
				static = {
					sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
					-- Another variant, because the more choice the better.
					-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
				},
				hl = { bold = true, fg = "fg", bg = "bg" },

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
					return " [" .. table.concat(names, " ") .. "] "
				end,
				hl = { fg = "fg", bg = "bg", bold = true },
			}

			-- Full nerd (with icon colors and clickable elements)!
			-- works in multi window, but does not support flexible components (yet ...)

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
						return self.status_dict.head and " " .. self.status_dict.head
					end,
					hl = { fg = "fg", bg = "bg", bold = true },
				},
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and (" +" .. count)
					end,
					hl = { fg = "green", bold = true, bg = "bg" },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and (" ~" .. count)
					end,
					hl = { fg = "yellow", bg = "bg", bold = true },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and (" -" .. count .. " ")
					end,
					hl = { fg = "red", bg = "bg", bold = true },
				},
			}
			-- Get diagnostic sign icons
			local function get_diagnostic_sign_text(severity)
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
						return count > 0 and (self.error_icon .. " " .. count .. " ")
					end,
					hl = { fg = "red", bg = "bg", bold = true },
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
						return count > 0 and (self.warn_icon .. " " .. count .. " ")
					end,
					hl = { fg = "yellow", bg = "bg", bold = true },
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
						return count > 0 and (self.info_icon .. " " .. count .. " ")
					end,
					hl = { fg = "blue", bg = "bg", bold = true },
				},
				{
					provider = function(self)
						local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
						return count > 0 and (self.hint_icon .. " " .. count .. " ")
					end,
					hl = { fg = "green", bg = "bg", bold = true },
				},
			}

			local WorkDir = {
				provider = function()
					local icon = (vim.fn.haslocaldir(0) == 1 and " l" or " g") .. " " .. "  "
					local cwd = vim.fn.getcwd(0)
					cwd = vim.fn.fnamemodify(cwd, ":~")
					if not conditions.width_percent_below(#cwd, 0.25) then
						cwd = vim.fn.pathshorten(cwd)
					end
					local trail = cwd:sub(-1) == "/" and " " or "/ "
					return icon .. cwd .. trail
				end,
				hl = { fg = "fg", bold = true, bg = "bg" },
			}

			-- Add to your statusline or winbar
			local StatusLine = {
				ViMode,
				FileNameBlock,
				Git,
				LSPActive,
				Diagnostics,
				{ provider = "%=" }, -- Right-align what follows
				Ruler,
				{ provider = " " },
				ScrollBar,
				hl = { bg = colors.bg },
			}

			-- Setup heirline
			require("heirline").setup({
				statusline = StatusLine,
				opts = {
					disable_winbar_cb = function(args)
						return conditions.buffer_matches({
							buftype = { "nofile", "prompt", "help", "quickfix" },
							filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
						}, args.buf)
					end,
				},
			})
		end,
	},
}
