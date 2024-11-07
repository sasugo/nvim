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
    vim.keymap.set("n", "<leader><F3>", dapui.toggle, {})
    vim.keymap.set("n", "<leader><F1>", dapui.open, {})
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
