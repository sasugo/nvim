local M = {}

function M.setup()
  require("nvim-navic").setup({
    auto_attach = true
  })
end

return M
