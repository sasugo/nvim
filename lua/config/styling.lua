local prettier = require("prettier")

prettier.setup({
  ["null_ls"] = {
    condition = function()
      return prettier.config_exists(
        { check_package_json = true }
      )
    end,
    runtime_condition = function(params)
      -- return false to skip running prettier
      return true
    end,
    timeout = 5000,
  },
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  cli_options = {
    semi = true,
    single_attribute_per_line = false,
    single_quote = false,
    tab_width = 6,
    trailing_comma = "es5",
    use_tabs = false
  },
  filetypes = {
    "css",
    "graphql",
    "html",
    "php",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "lua"
  },
})
