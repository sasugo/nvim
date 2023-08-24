local M = {}

function M.setup()
  require("icon-picker").setup({
    disable_legacy_commands = true
  })
end

return M
