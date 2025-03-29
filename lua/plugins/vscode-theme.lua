return {
  "Mofiqul/vscode.nvim",
  init = function()
    local opt = vim.opt
    opt.background = "dark"
    vim.cmd([[colorscheme vscode]])
  end,
}
