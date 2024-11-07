return {
  "L3MON4D3/Luasnip",
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.set_config({
      history = false,
      updateevents = "TextChanged,TextChangedI",
    })
  end,
}
