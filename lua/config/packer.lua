-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "savq/melange"
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Tree navigation
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use {'junegunn/fzf.vim'}
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  --use {
  --  'nvim-tree/nvim-tree.lua',
  --  requires = {
  --    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  --  },
  --  --tag = 'nightly' -- optional, updated every week. (see issue #1193)
  --}

  -- cmp pluggins
  --use 'folke/tokyonight.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'robertmeta/nofrils'
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/Luasnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- bunch of snippets

  	-- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer

  -- Styling code
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  --debuging
  use 'mfussenegger/nvim-dap'

  --auto-pair
  use 'windwp/nvim-autopairs'

  -- Colorschemes
  -- use 'ellisonleao/gruvbox.nvim'
  use "rebelot/kanagawa.nvim"
  use {"catppuccin/nvim", as = "catppuccin"}
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'} use 'norcalli/nvim-colorizer.lua'


  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
 end)
