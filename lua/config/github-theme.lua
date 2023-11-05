local M = {}

function M.setup()
  require('github-theme').setup({
    options = {
      transparent = true,
      styles = {
        comments = 'italic',
        keywords = 'bold',
        types = 'italic,bold',
      }
    }
  })
end

return M
