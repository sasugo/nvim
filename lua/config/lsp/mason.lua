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
