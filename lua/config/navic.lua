local M = {}

function M.setup()
  require("nvim-navic").setup({
    auto_attach = true
  })
  --local navic = require("nvim-navic")

  --require("lspconfig").clangd.setup {
  --  on_attach = function(client, bufnr)
  --    navic.attach(client, bufnr)
  --  end
  --}
  print("Navic is initialized")
end

return M
