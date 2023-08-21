local M = {}

function M.setup()
  require("gitblame").setup({
    enabled = true
  })
end

return M
