local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout_ms = 10000 })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async, timeout_ms = 10000 })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout_ms = 10000 })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

local prettier = require("prettier")

prettier.setup({
  ["null_ls"] = {
    condition = function()
      return prettier.config_exists({
        check_package_json = true
      })
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
    tab_width = 2,
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
  },
})
