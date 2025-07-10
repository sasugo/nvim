return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        default_ignore_patterns = {
          "node_modules",
          "vendor",
        },
        theme = "dropdown",
      },
      pickers = {
        buffers = { -- Moved buffers config here under pickers
          sort_mru = true,
          ignore_current_buffer = true,
          theme = "dropdown",
          previewer = true,
          layout_config = {
            width = 0.8,
            height = 0.8,
          },
        },
        lsp_references = {
          theme = "dropdown",
          layout_config = {
            width = 0.8,
            height = 0.8,
          },
        },
        find_files = {
          theme = "dropdown",
          layout_config = {
            width = 0.8,
            height = 0.8,
          },
          hidden = true,
          previewer = true,
          no_ignore = true,
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          theme = "dropdown",
          layout_config = {
            width = 0.8,
            height = 0.8,
          },
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
      },
    })

    telescope.load_extension("live_grep_args")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("x", "<leader>ss", '"zy<Cmd>Telescope live_grep<CR><C-r>z', {})

    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
    vim.keymap.set("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)
  end,
}
