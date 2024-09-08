-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  use("savq/melange")
  use("nvim-lua/popup.nvim")   -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  --Latex
  use("lervag/vimtex")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-live-grep-args.nvim" } },
  })

  use("kevinhwang91/rnvimr")

  use("hrsh7th/nvim-cmp")
  use("robertmeta/nofrils")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")

  -- snippets
  use("L3MON4D3/Luasnip")             -- snippet engine
  use("rafamadriz/friendly-snippets") -- bunch of snippets

  -- LSP
  use("neovim/nvim-lspconfig")             -- enable LSP
  use("williamboman/mason.nvim")           -- simple to use language server installer
  use("williamboman/mason-lspconfig.nvim") -- simple to use language server installer

  use("onsails/lspkind.nvim")

  -- Styling code
  use("jose-elias-alvarez/null-ls.nvim")
  use("MunifTanjim/prettier.nvim")

  --debuging
  use("mfussenegger/nvim-dap")
  use("mfussenegger/nvim-dap-python")

  --auto-pair
  use("windwp/nvim-autopairs")

  -- Colorschemes
  use("ellisonleao/gruvbox.nvim")
  use("rebelot/kanagawa.nvim")
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "akinsho/bufferline.nvim", tag = "v4.7.0", requires = "nvim-tree/nvim-web-devicons" })
  use("norcalli/nvim-colorizer.lua")

  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  })

  -- Neotree
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        -- make a group to be able to delete it later
        group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
        callback = function()
          local f = vim.fn.expand("%:p")
          if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd("Neotree current dir=" .. f)
            -- neo-tree is loaded now, delete the init autocmd
            vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
          end
        end,
      })
    end,
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    },
  })

  -- Aerial
  use({
    "stevearc/aerial.nvim",
  })

  -- Fine Cmdline
  use({
    "VonHeikemen/fine-cmdline.nvim",
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
  })

  --Navbuddy
  use({
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",         -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
    },
  })

  --Deepwhite
  use({ "Verf/deepwhite.nvim" })

  --Git Blame
  use("f-person/git-blame.nvim")

  --Emoji support
  use("stevearc/dressing.nvim")
  use("ziontee113/icon-picker.nvim")

  --term
  use({ "akinsho/toggleterm.nvim", tag = "*" })

  --Lazygit
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  -- Github theme
  use({ "projekt0n/github-nvim-theme" })

  -- Hardtime
  use({ "m4xshen/hardtime.nvim", requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" } })

  -- Other
  use("rgroli/other.nvim")

  -- Zenbones
  use({
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim",
  })

  -- oxocarbon
  use({ "nyoom-engineering/oxocarbon.nvim" })

  -- Oil
  use({ "stevearc/oil.nvim" })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  --Render Markdown
  use({
    "MeanderingProgrammer/render-markdown.nvim",
    after = { "nvim-treesitter" },
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  })


  -- Obsidian
  use({
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  use("folke/tokyonight.nvim")
end)
