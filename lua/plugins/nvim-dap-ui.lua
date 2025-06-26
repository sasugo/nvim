return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap_ok, dap = pcall(require, "dap")
    if not dap_ok then
      return
    end

    local dapui_ok, dapui = pcall(require, "dapui")
    if not dapui_ok then
      return
    end

    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "/home/gonzalo/dev/vscode-php-debug/out/phpDebug.js" },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    dap.adapters.coreclr = {
      type = "executable",
      command = "/usr/local/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    local cwd = vim.fn.getcwd()
    local dap_python = require("dap-python")
    dap_python.setup("~/.virtualenvs/debugpy/bin/python")

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
      name = "BPKT - Docker User Service",
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

    table.insert(dap.configurations.python, {
      type = "python",
      name = "BPKT - Docker Training Service",
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
      name = "BPKT - Docker File Management Service",
      request = "attach",
      mode = "remote",
      port = 10194,
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
      name = "BPKT - Docker Report Service",
      request = "attach",
      mode = "remote",
      port = 10193,
      host = "localhost",
      cwd = cwd,
      pathMappings = {
        {
          localRoot = cwd,
          remoteRoot = "/app",
        },
      },
    })

    local js_based_languages = { "typescript", "javascript", "typescriptreact" }
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Launch Angular in Chrome
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Angular in Chrome",
          url = "http://localhost:4200",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          port = 0, -- Use 0 to let the adapter pick a free port
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach to Chrome",
          url = "http://localhost:4200",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          port = 9222, -- Chrome's default debug port
        },
        -- Debug Node.js-based Angular SSR
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Angular SSR",
          program = "${workspaceFolder}/dist/server/main.js", -- Adjust to your build output
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = { "-r", "ts-node/register" },
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        -- Attach to Node.js process
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node.js",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    dapui.setup()
  end,

  keys = {
    { "<leader>b",  "<cmd>lua require('dap').toggle_breakpoint() <CR>", mode = "n", desc = "Toggle Breakpoint" },
    { "<leader>B",  "<cmd>lua require('dap').set_breakpoint() <CR>",    mode = "n", desc = "Set Breakpoint" },
    { "<leader>dr", "<cmd>lua require('dap').repl.open() <CR>",         mode = "n", desc = "DAP REPL Open" },
    { "<leader>dl", "<cmd>lua require('dap').run_last() <CR>",          mode = "n", desc = "DAP Run Last" },
    { "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover() <CR>",  mode = "v", desc = "DAP UI Widgets Hover" },
    {
      "<leader>dp",
      "<cmd>lua require('dap.ui.widgets').preview() <CR>",
      mode = "n",
      desc = "DAP UI Widgets Preview",
    },
    {
      "<leader>df",
      "<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames) <CR>",
      mode = "n",
      desc = "DAP UI Widgets Centered Float",
    },
    { "<F1>", "<cmd>lua require('dap').continue() <CR>",  mode = "n", desc = "DAP Continue" },
    { "<F2>", "<cmd>lua require('dap').step_into() <CR>", mode = "n", desc = "DAP Step Into" },
    { "<F3>", "<cmd>lua require('dap').step_out() <CR>",  mode = "n", desc = "DAP Step Out" },
    { "<F4>", "<cmd>lua require('dap').step_over() <CR>", mode = "n", desc = "DAP Step Over" },
  },
}
