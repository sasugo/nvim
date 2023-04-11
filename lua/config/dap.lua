local dap = require'dap'
dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {"/home/gonzalo/dev/vscode-php-debug/out/phpDebug.js"},
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = '9003',
    },
}
