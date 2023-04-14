local M = {}

function M.setup()

 require ("catppuccin").setup({
   flavour = "macchiato",
   transparent_background = false,
   backgroud = {
     light = "latte",
     dark = "macchiato"
   },
   term_colors = true,
   styles = {
     functions = {"italic"},
     keywords = {"bold"},
   },
   integrations = {
     mason = true,
     nvimtree = true,
     cmp = true,
     telescope = true
   },
   color_overrides = {
     latte = {
       green = "#26851A",
       flamingo = "#A34F4F",
       crust = "#e0d39d",
       rosewater = "#C16651",
       mantle = "#ffffff",
       base = "#ffffff",
       pink = "#67367E",
       peach = "#D85821",
       text = "#2d2018"
     }
   }
 })

end
return M
