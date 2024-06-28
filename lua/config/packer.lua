-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "savq/melange"
  use "nvim-lua/popup.nvim"   -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  --Latex
  use 'lervag/vimtex'

  -- Tree navigation
  use {
    'junegunn/fzf.vim',
    requires = { { 'junegunn/fzf', dir = "./fzf", run = ':call fzf#install()' }, { 'ibhagwan/fzf-lua' } }
  }

  use 'kevinhwang91/rnvimr'

  use 'hrsh7th/nvim-cmp'
  use 'robertmeta/nofrils'
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/Luasnip"             -- snippet engine
  use "rafamadriz/friendly-snippets" -- bunch of snippets

  -- LSP
  use "neovim/nvim-lspconfig"             -- enable LSP
  use "williamboman/mason.nvim"           -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer

  use "onsails/lspkind.nvim"

  -- Styling code
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  --debuging
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'

  --auto-pair
  use 'windwp/nvim-autopairs'

  -- Colorschemes
  use 'ellisonleao/gruvbox.nvim'
  use "rebelot/kanagawa.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use { 'akinsho/bufferline.nvim', tag = "v4.6.1", requires = 'nvim-tree/nvim-web-devicons' }
  use 'norcalli/nvim-colorizer.lua'

  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

  -- Neotree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Aerial
  use {
    'stevearc/aerial.nvim',
  }

  -- Fine Cmdline
  use {
    'VonHeikemen/fine-cmdline.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' }
    }
  }

  --Navbuddy
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    }
  }

  --Deepwhite
  use { 'Verf/deepwhite.nvim' }

  --Git Blame
  use 'f-person/git-blame.nvim'

  --Emoji support
  use "stevearc/dressing.nvim"
  use "ziontee113/icon-picker.nvim"

  --term
  use { "akinsho/toggleterm.nvim", tag = '*' }

  --Lazygit
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  -- Github theme
  use({ 'projekt0n/github-nvim-theme' })

  -- Hardtime
  use({ "m4xshen/hardtime.nvim", requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" } })

  -- Other
  use "rgroli/other.nvim"

  -- Zenbones
  use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim"
  }

  -- oxocarbon
  use { 'nyoom-engineering/oxocarbon.nvim' }
end)
