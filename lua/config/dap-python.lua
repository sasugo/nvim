local dap = require("dap")
local M = {}
function M.setup()
  require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
  require('dap-python').resolve_python = function()
    return '/home/gonzalo/dev/bpk-training/training-service/venv/bin/python'
  end

  table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "Module App",
    console = "integratedTerminal",
    module = "app", -- edit this to be your app's main module
    cwd = "${workspaceFolder}",
  })
  table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "Module main",
    console = "integratedTerminal",
    module = "main", -- edit this to be your app's main module
    cwd = "${workspaceFolder}",
  })
end

return M
