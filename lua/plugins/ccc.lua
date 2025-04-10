return {
  "uga-rosa/ccc.nvim",
  event = "BufReadPre", -- Load before opening a buffer
  config = function()
    local ccc = require("ccc")

    -- Basic setup for ccc.nvim
    ccc.setup({

      highlighter = {
        auto_enable = true, -- Automatically highlight colors in the buffer
        lsp = true,     -- Enable LSP color integration if available (optional)
      },
    })

    -- Key mappings
    local map = vim.keymap.set

    -- Normal mode mappings
    map("n", "<leader>cp", ":CccPick<CR>", { desc = "Open color picker" })
    map("n", "<leader>cc", ":CccConvert<CR>", { desc = "Convert color under cursor" })
    map("n", "<leader>ct", ":CccHighlighterToggle<CR>", { desc = "Toggle color highlighter" })

    -- Insert mode mapping for quick color picking
    map("i", "<C-A-c>", "<Esc>:CccPick<CR>", { desc = "Pick color from insert mode" })
  end,
}
