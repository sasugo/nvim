local dap = require 'dap'
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { "/home/gonzalo/dev/vscode-php-debug/out/phpDebug.js" },
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Intelges Services - Docker - XDebug',
    port = '9003',
    pathMappings = {
      ['/app'] = "${workspaceFolder}", }
  },
}

dap.adapters.coreclr = {
  type = 'executable',
  command = '/usr/local/bin/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
