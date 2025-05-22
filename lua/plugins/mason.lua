return {
  { "williamboman/mason.nvim", opts = {}, tag = "v1.11.0" },

  {
    "williamboman/mason-lspconfig.nvim",
    tag = "v1.32.0",
    dependencies = { { "neovim/nvim-lspconfig" }, "SmiteshP/nvim-navic" },
    opts = {},
  },
}
