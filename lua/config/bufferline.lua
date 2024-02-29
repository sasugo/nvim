local M = {}
function M.setup()
  require("bufferline").setup({
    options = {
      separator_style = "thin",
      diagnostics = "nvim_lsp",
      color_icons = true,
      show_buffer_icons = true,
      numbers = function(opts)
        return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
      end,
      indicator = {
        style = "underline",
      },
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      show_buffer_close_icons = true,
    }
  })
end

return M
