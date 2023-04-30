local vim = vim
local opt = vim.opt

opt.guicursor = ""
opt.nu = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 2
opt.hlsearch = false
opt.incsearch = true
opt.title = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.smartindent = true
opt.cindent = true
opt.wrap = false

vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('lualine').setup()


