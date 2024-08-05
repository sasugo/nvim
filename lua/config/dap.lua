local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	return
end

local M = {}

M.setup = function()
	dap.adapters.php = {
		type = "executable",
		command = "node",
		args = { "/home/gonzalo/dev/vscode-php-debug/out/phpDebug.js" },
	}

	dap.configurations.php = {
		{
			type = "php",
			request = "launch",
			name = "Intelges Services - Docker - XDebug",
			port = "9003",
			pathMappings = {
				["/app"] = "${workspaceFolder}",
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

	-- Python configuration
	require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
	require("dap-python").resolve_python = function()
		return "/home/gonzalo/dev/bpk-training/training-service/venv/bin/python"
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
