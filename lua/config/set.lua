vim.opt.guicursor = ""
vim.opt.bg = "light"
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

-- Setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
    update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    -- adaptive_size = true,
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  actions = {
    open_file = {
      resize_window = true
    }
  },
  renderer = {
    group_empty = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  filters = {
    dotfiles = false
  },
})

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
