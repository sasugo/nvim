local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local cwd = vim.fn.getcwd()
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "Module App",
  cwd = cwd,
  module = "app",
  pythonPath = function()
    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
      return cwd .. "/venv/bin/python"
    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
      return cwd .. "/.venv/bin/python"
    else
      return "/usr/bin/python"
    end
  end,
})

table.insert(dap.configurations.python, {
  type = "python",
  name = "BPKT - Remote Training Service",
  request = "attach",
  mode = "remote",
  port = 10192,
  host = "localhost",
  cwd = cwd,
  pathMappings = {
    {
      localRoot = cwd,
      remoteRoot = "/app",
    },
  },
})
table.insert(dap.configurations.python, {
  type = "python",
  name = "BPKT - Remote User Service",
  request = "attach",
  mode = "remote",
  port = 10191,
  host = "localhost",
  cwd = cwd,
  pathMappings = {
    {
      localRoot = cwd,
      remoteRoot = "/app",
    },
  },
})
