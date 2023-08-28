local M = {}
function M.setup()
  require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
  require('dap-python').resolve_python = function()
    return '/home/gonzalo/dev/mpc_hmi_gateway/venv/bin/python'
  end

  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "Module",
    console = "integratedTerminal",
    module = "main", -- edit this to be your app's main module
    cwd = "${workspaceFolder}",
  })
end

return M
