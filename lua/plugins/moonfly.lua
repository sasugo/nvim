return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  init = function()
    -- Lua initialization file
    vim.g.moonflyTransparent = true
    -- Lua cursor
    vim.g.moonflyCursorColor = true
    vim.cmd([[colorscheme moonfly]])
  end
}
