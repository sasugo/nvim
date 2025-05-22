return {
  { "williamboman/mason.nvim", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { { "neovim/nvim-lspconfig", lazy = false }, "SmiteshP/nvim-navic" },
    opts = {},
  },
}
