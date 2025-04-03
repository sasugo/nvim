return {
  "rebelot/kanagawa.nvim",
  config = true,
  init = function ()
    local opt = vim.opt
    opt.background = "dark"
    vim.cmd([[colorscheme kanagawa-dragon]])
  end
}
