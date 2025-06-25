local servers = {
  "html",
  "htmx",
  "emmet_ls",
  "lua_ls",
  "ts_ls",
  "intelephense",
  "css_variables",
  "cssls",
  "cssmodules_ls",
  "omnisharp",
  "texlab",
  "jedi_language_server",
  "angularls",
  "js-debug-adapter",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.TRACE,
  max_concurrent_installers = 4,
}

-- Check if lspconfig is available
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  print("Error: nvim-lspconfig not found")
  return
end

-- Setup mason
require("mason").setup(settings)

-- Setup mason-lspconfig (if available)
local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_status_ok then
  mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
  })
end

-- Configure LSP servers with deduplication
for _, server in pairs(servers) do
  -- Check if the server is already running
  local clients = vim.lsp.get_clients({ name = server })
  if #clients == 0 then
    local opts = {
      on_attach = require("config.lsp.handlers").on_attach,
      capabilities = require("config.lsp.handlers").capabilities,
      settings = {}, -- Standardize on empty table
    }

    -- Apply server-specific settings
    if server == "lua_ls" then
      opts.settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      }
    end

    -- Load custom settings if available
    local require_ok, conf_opts = pcall(require, "config.lsp.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end
