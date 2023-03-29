local map = require("config.keymap").map

map("n", "<leader>pv", ":wincmd v<bar> :Ex <bar> :vertical resize 30<CR>")
map("n", "<leader>t", "<cmd>NvimTreeToggle<CR>")
map("n", "<F7>", "<C-w><S-w>")
map("n", "<F8>", "<C-w>w")
map("n", "<C-P>", "<cmd>FZF<CR>")
