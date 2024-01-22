local M = {}

function M.setup()
  require('github-theme').setup({
    options = {
      hide_end_of_buffer = true,
      transparent = false,
      styles = {
        comments = 'italic',
        keywords = 'bold',
        types = 'italic,bold',
      }
    }
  })
end

return M
