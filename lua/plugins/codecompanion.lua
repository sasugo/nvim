return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      send_code = true,
      log_level = "TRACE",
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
        inline = {
          layout = "vertical", -- vertical|horizontal|buffer
        },
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = os.getenv("ANTHROPIC_API_KEY"),
            },
            schema = {
              extended_thinking = {
                type = false,
                default = false,
              },
            },
          })
        end,
      },
    })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "CodeCompanionChat" },
      callback = function()
        vim.bo.filetype = "markdown"
      end,
    })
  end,
}
