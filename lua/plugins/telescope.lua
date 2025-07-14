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
        layout_strategy = "horizontal", -- or 'vertical', 'flex', etc.
        path_display = { truncate = 3 },
        default_ignore_patterns = {
          "node_modules",
          "vendor",
        },
        layout_config = {
          horizontal = {
            preview_width = 0.6, -- Increase preview window to 60% of the total width
            width = 0.9,       -- Total width of Telescope window (90% of screen)
            height = 0.9,      -- Total height of Telescope window (90% of screen)
            prompt_position = "top", -- Position of the prompt
          },
          vertical = {
            preview_height = 0.6, -- Increase preview height to 60% of the total height
            width = 0.9,
            height = 0.9,
          },
        },
      },
      pickers = {
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
        },
        find_files = {
          hidden = true,
          no_ignore = true,
          previewer = true,
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
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
