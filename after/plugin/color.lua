--vim.g.tokyonight_transparent_sidebar = true
--vim.g.tokyohight_transparent = true
--vim.cmd("colo nofrils-light")
vim.o.termguicolors = true
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = false,       -- adjust window separators highlight for laststatus=3
    terminalColors = true,      -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = "light"           -- Load "default" theme or the experimental "light" theme
})
vim.cmd ([[colorscheme kanagawa]])
vim.o.background = "light"

