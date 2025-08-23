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
opt.inccommand = "split"
opt.title = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.directory = "/tmp"
opt.conceallevel = 2
opt.colorcolumn = "80"
opt.cursorcolumn = true
opt.cursorline = true

opt.smartindent = true
opt.cindent = true
opt.wrap = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- VimLatex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"

-- Cursor
opt.guicursor = {
  "n-v-c:block",      -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25",    -- Insert, command-line insert, visual-exclude: thin vertical bar (25% width)
  "r-cr:hor20",       -- Replace, command-line replace: horizontal bar (20% height)
  "sm:block-blinkon0", -- Showmatch: block cursor, no blinking
}
