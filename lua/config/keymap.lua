local opts = { noremap = true, silent = true }
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('x', '<leader>ss', '"zy<Cmd>Telescope live_grep<CR><C-r>z', {})

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Styling --
keymap("n", "<leader>f", "<cmd>Prettier<CR>", opts)

keymap("t", "<A-A>", "<ESC>A", term_opts)
keymap("t", "<A-B>", "<ESC>B", term_opts)
keymap("t", "<A-D>", "<ESC>D", term_opts)
keymap("t", "<A-F>", "<ESC>F", term_opts)

--Error highlighting
keymap("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", term_opts)
keymap("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", term_opts)
keymap("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", term_opts)
keymap("n", "<leader>dd", "<cmd>lua vim.diagnostic.setloclist()<CR>", term_opts)

--Dap debugging
keymap("n", "<leader>b", "<cmd>lua require('dap').toggle_breakpoint() <CR>", term_opts)
keymap("n", "<leader>B", "<cmd>lua require('dap').set_breakpoint() <CR>", term_opts)
keymap(
  "n",
  "<leader>lp",
  "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) <CR>",
  term_opts
)
keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.open() <CR>", term_opts)
keymap("n", "<leader>dl", "<cmd>lua require('dap').run_last() <CR>", term_opts)
keymap("v", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover() <CR>", term_opts)
keymap("n", "<leader>dp", "<cmd>lua require('dap.ui.widgets').preview() <CR>", term_opts)
keymap(
  "n",
  "<leader>df",
  "<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames) <CR>",
  term_opts
)
keymap("n", "<F1>", "<cmd>lua require('dap').continue() <CR>", term_opts)
keymap("n", "<F2>", "<cmd>lua require('dap').step_into() <CR>", term_opts)
keymap("n", "<F3>", "<cmd>lua require('dap').step_out() <CR>", term_opts)
keymap("n", "<F4>", "<cmd>lua require('dap').step_over() <CR>", term_opts)

--Navbuddy
keymap("n", "<leader>a", "<cmd>Navbuddy<CR>", term_opts)

-- Fine cmdline
--keymap("n", "<CR>", "<cmd>FineCmdline<CR>", term_opts)

--UFO
keymap("n", "zR", "<cmd>lua require('ufo').openAllFolds()<CR>", term_opts)
keymap("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", term_opts)
keymap("n", "zr", "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>", term_opts)
keymap("n", "zm", "<cmd>lua require('ufo').closeFoldsWith()<CR>", term_opts)
vim.keymap.set("n", "zP", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    -- choose one of coc.nvim and nvim lsp
    vim.fn.CocActionAsync("definitionHover") -- coc.nvim
    vim.lsp.buf.hover()
  end
end, term_opts)

--Emoji
keymap("n", "<leader><leader>i", "<cmd>IconPickerNormal emoji nerd_font_v3 alt_font symbols<cr>", term_opts)
keymap("n", "<leader><leader>y", "<cmd>IconPickerYank emoji nerd_font_v3 alt_font symbols<cr>", term_opts)
keymap("i", "<C-i>", "<cmd>IconPickerInsert emoji nerd_font_v3 alt_font symbols<cr>", term_opts)

--LazyGit
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", term_opts)

-- Other keymapping
keymap("n", "<leader>lz", "<cmd>:Other<cr>", term_opts)
keymap("n", "<leader>lt", "<cmd>:Other test<cr>", term_opts)
keymap("n", "<leader>ls", "<cmd>:Other scss<cr>", term_opts)
keymap("n", "<leader>lh", "<cmd>:Other html<cr>", term_opts)
keymap("n", "<leader>lc", "<cmd>:Other component<cr>", term_opts)

-- Oil
keymap("n", "<leader>-", "<cmd>Oil --float<CR>", opts)

--Neo Tree
keymap("n", "<leader>n", "<cmd>Neotree toggle<cr>", opts)
