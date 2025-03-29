return {
  "navarasu/onedark.nvim",
  opts = {
    style = "warmer",
  },
  init = function()
    local opt = vim.opt
    opt.background = "dark"
    vim.cmd([[colorscheme onedark]])
  end,
}
