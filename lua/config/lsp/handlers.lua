local M = {}

-- Define diagnostic signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

-- Setup function for diagnostics and global LSP handlers
M.setup = function()
  -- Define signs
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- Configure diagnostics
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- Could be '■', '▎', 'x'
    },
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      source = "always",
      border = "rounded",
    },
  })

  -- Set global LSP handlers for hover and signature help
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- Document highlighting autocommands
local function lsp_highlight_document(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Keymaps for LSP
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>kf", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float({ border = "rounded" })
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({ border = "rounded" })
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({ border = "rounded" })
  end, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  -- Custom command for formatting
  vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.format, {})
end

-- On-attach function for LSP clients
M.on_attach = function(client, bufnr)
  -- Disable formatting for specific servers
  if client.name == "ts_ls" or client.name == "html" or client.name == "cssls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  -- Set up keymaps and highlighting
  lsp_keymaps(bufnr)
  lsp_highlight_document(client, bufnr)

  -- Attach nvim-navic and nvim-navbuddy if supported
  if client.server_capabilities.documentSymbolProvider then
    local ok_navic, navic = pcall(require, "nvim-navic")
    if ok_navic then
      navic.attach(client, bufnr)
    end
    local ok_navbuddy, navbuddy = pcall(require, "nvim-navbuddy")
    if ok_navbuddy then
      navbuddy.attach(client, bufnr)
    end
  end
end

-- Set up client capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enhance capabilities with cmp_nvim_lsp if available
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = vim.tbl_deep_extend("force", M.capabilities, cmp_nvim_lsp.default_capabilities())
end

return M
