vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.title = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.wrap = false

vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('lualine').setup()


