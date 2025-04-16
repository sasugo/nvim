return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",           -- Use latest version
    opts = {
      shade_terminals = true, -- Slightly darken inactive terminals
      start_in_insert = true, -- Start in insert mode
      insert_mappings = true, -- Allow mappings in insert mode
      terminal_mappings = true, -- Allow mappings in terminal mode
      persist_size = true,   -- Remember size of splits
      close_on_exit = true,  -- Close terminal when process exits },
      open_mapping = [[<leader>tf]],
      direction = "float",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
    init = function()
      local Terminal = require("toggleterm.terminal").Terminal
      vim.keymap.set("n", "<leader>tv", function()
        local term = Terminal:new({ direction = "vertical" })
        term:toggle()
      end, { desc = "Toggle vertical terminal 1" })
    end,
  },
}
