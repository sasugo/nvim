return {
  cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "", "--forceStrictTemplates" },
  on_attach = require("config.lsp.handlers").on_attach,
  capabilities = require("config.lsp.handlers").capabilities,
}
