local M = {}
local bufferline = require("bufferline")
function M.setup()
  bufferline.setup({
    options = {
      style_preset = bufferline.style_preset.minimal,
      themable = true,
      separator_style = "thick",
      diagnostics = "nvim_lsp",
      color_icons = true,
      show_buffer_icons = true,
      numbers = function(opts)
        return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
      end,
      indicator = {
        style = "icon",
      },
      buffer_close_icon = '󰅖',
      modified_icon = '●',
      show_tab_indicators = true,
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      show_buffer_close_icons = true,
    }
  })
end

return M
