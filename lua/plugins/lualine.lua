return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local kanagawa_dragon = {
      normal = {
        a = { fg = "#1F1F28", bg = "#FF9E3B", gui = "bold" },-- roninYellow on sumiInk1 
        b = { fg = "#DCD7BA", bg = "#2A2A37" },             -- fujiWhite on sumiInk2
        c = { fg = "#727169", bg = "#1F1F28" },             -- fujiGray on sumiInk1
      },
      insert = {
        a = { fg = "#1F1F28", bg = "#98BB6C", gui = "bold" }, -- springGreen on sumiInk1
        b = { fg = "#DCD7BA", bg = "#2A2A37" },             -- fujiWhite on sumiInk2
        c = { fg = "#727169", bg = "#1F1F28" },             -- fujiGray on sumiInk1
      },
      visual = {
        a = { fg = "#1F1F28", bg = "#FFA066", gui = "bold" }, -- surimiOrange on sumiInk1
        b = { fg = "#DCD7BA", bg = "#2A2A37" },             -- fujiWhite on sumiInk2
        c = { fg = "#727169", bg = "#1F1F28" },             -- fujiGray on sumiInk1
      },
      replace = {
        a = { fg = "#1F1F28", bg = "#E82424", gui = "bold" }, -- samuraiRed on sumiInk1
        b = { fg = "#DCD7BA", bg = "#2A2A37" },             -- fujiWhite on sumiInk2
        c = { fg = "#727169", bg = "#1F1F28" },             -- fujiGray on sumiInk1
      },
      command = {
        a = { fg = "#1F1F28", bg = "#7E9CD8", gui = "bold" }, -- dragonBlue on sumiInk1
        b = { fg = "#DCD7BA", bg = "#2A2A37" },             -- fujiWhite on sumiInk2
        c = { fg = "#727169", bg = "#1F1F28" },             -- fujiGray on sumiInk1
      },
      inactive = {
        a = { fg = "#727169", bg = "#16161D", gui = "bold" }, -- fujiGray on sumiInk0
        b = { fg = "#727169", bg = "#1F1F28" },             -- fujiGray on sumiInk1
        c = { fg = "#54546D", bg = "#1F1F28" },             -- sumiInk4 on sumiInk1
      },
    }
    require("lualine").setup({
      options = {
        theme = kanagawa_dragon,
         section_separators = { left = "", right = "" },
         component_separators = { left = "", right = "" },
         globalstatus = true, -- Optional: single statusline for all windows,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 1,       -- Show relative path
            shorting_target = 40, -- Shorten if longer than 40 characters
          },
        },
        lualine_x = {
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
