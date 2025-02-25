local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      condition = function(utils)
        return utils.root_has_file({ ".prettierrc" })
      end,
    }),
    formatting.black,
    formatting.stylua,
    diagnostics.flake8,
    diagnostics.eslint_d.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "html", "spec.ts" },
    }),
    formatting.phpcbf,
    formatting.csharpier,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout = 5000 })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})
