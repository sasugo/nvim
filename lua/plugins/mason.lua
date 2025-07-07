return {
  { "williamboman/mason.nvim", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { { "neovim/nvim-lspconfig" }, "SmiteshP/nvim-navic" },
    opts = {},
  },
}
