return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  lazy = false,
  config = function()
    local none_ls_status_ok, none_ls = pcall(require, "none-ls")
    if not none_ls_status_ok then
      return
    end
    local augroup = vim.api.nvim_create_augroup("Format", { clear = true })

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = none_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    none_ls.setup({
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
          condition = function(utils)
            return utils.root_has_file({
              ".eslintrc.js",
              ".eslintrc.json",
              ".eslintrc.cjs",
              "eslint.config.js",
              "eslint.config.mjs",
            })
          end,
        }),
        formatting.phpcbf,
        formatting.csharpier,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout_ms = 10000 })
          end, { buffer = bufnr, desc = "[lsp] format" })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            desc = "Format the buffer before saving it",
            callback = function()
              vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
            end,
          })
        end
      end,
    })
  end,
}
