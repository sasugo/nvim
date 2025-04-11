return {

  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
          dragon = {
            diag = {
              error = "#E82424",
              hint = "#6A9589",
              info = "#658594",
              ok = "#98BB6C",
              warning = "#D4A017",
            },
            diff = {
              add = "#2B3328",
              change = "#252535",
              delete = "#43242B",
              text = "#49443C",
            },
            syn = {
              comment = "#737c73",
              constant = "#b6927b",
              deprecated = "#717C7C",
              fun = "#8ba4b0",
              identifier = "#D4A017",
              keyword = "#8992a7",
              number = "#a292a3",
              operator = "#c4746e",
              parameter = "#a6a69c",
              preproc = "#c4746e",
              punct = "#9e9b93",
              regex = "#c4746e",
              special1 = "#949fb5",
              special2 = "#c4746e",
              special3 = "#c4746e",
              statement = "#8992a7",
              string = "#8a9a7b",
              type = "#8ea4a2",
              variable = "none",
            },
            term = {
              "#0d0c0c",
              "#c4746e",
              "#8a9a7b",
              "#D4A017",
              "#8ba4b0",
              "#a292a3",
              "#8ea4a2",
              "#C8C093",
              "#a6a69c",
              "#E46876",
              "#87a987",
              "#E6C384",
              "#7FB4CA",
              "#938AA9",
              "#7AA89F",
              "#c5c9c5",
              "#b6927b",
              "#b98d7b",
            },
            ui = {
              bg = "#181616",
              bg_dim = "#12120f",
              bg_gutter = "none",
              bg_m1 = "#1D1C19",
              bg_m2 = "#12120f",
              bg_m3 = "#0d0c0c",
              bg_p1 = "#282727",
              bg_p2 = "#393836",
              bg_search = "#2D4F67",
              bg_visual = "#223249",
              fg = "#c5c9c5",
              fg_dim = "#C8C093",
              fg_reverse = "#223249",
              float = {
                bg = "#0d0c0c",
                bg_border = "#0d0c0c",
                fg = "#C8C093",
                fg_border = "#54546D",
              },
              nontext = "#625e5a",
              pmenu = {
                bg = "#223249",
                bg_sbar = "#223249",
                bg_sel = "#2D4F67",
                bg_thumb = "#2D4F67",
                fg = "#DCD7BA",
                fg_sel = "none",
              },
              special = "#7a8382",
              whitespace = "#625e5a",
            },
            vcs = {
              added = "#76946A",
              changed = "#DCA561",
              removed = "#C34043",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    })
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
