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
            -- Check for .prettierrc or .prettierrc.json
            local has_prettierrc = utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
            -- Check for package.json with a "prettier" field
            local has_package_json_with_prettier = false
            if utils.root_has_file({ "package.json" }) then
              local package_json_path = vim.fn.findfile("package.json", vim.fn.getcwd() .. ";")
              if package_json_path ~= "" then
                local package_json = vim.fn.json_decode(vim.fn.readfile(package_json_path))
                has_package_json_with_prettier = package_json and package_json.prettier ~= nil
              end
            end

            -- Return true if either condition is met
            return has_prettierrc or has_package_json_with_prettier
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
            local has_eslint_config = utils.root_has_file({
              ".eslintrc.js",
              ".eslintrc.json",
              ".eslintrc.cjs",
              "eslint.config.js",
              "eslint.config.mjs",
            })
            return has_eslint_config
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
