local M = {}
function M.setup()
  require("bufferline").setup({
    options = {
      separator_style = "thic",
      numbers = function(opts)
        return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
      end,
      indicator = {
        style = "underline"
      }
    }
  })
end

return M
