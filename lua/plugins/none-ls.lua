return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  lazy = false,
  config = function()
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
      return
    end
    local augroup = vim.api.nvim_create_augroup("Format", { clear = true })

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    null_ls.setup({
      debug = false,
      sources = {
        formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file({ ".prettierrc" })
          end,
        }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        require("none-ls.diagnostics.flake8"),
        require("none-ls.diagnostics.eslint_d").with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "html",
            "spec.ts",
          },
        }),
        formatting.phpcbf,
        formatting.csharpier,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
          end, { buffer = bufnr, desc = "[lsp] format" })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            desc = "Format the buffer before saving it",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}