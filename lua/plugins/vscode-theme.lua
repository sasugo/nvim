return {
  "Mofiqul/vscode.nvim",
  enabled = false,
  init = function()
    local opt = vim.opt
    opt.background = "dark"
    vim.cmd([[colorscheme vscode]])
  end,
}
