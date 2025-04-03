-- Function to get the current buffer name
local function get_buffer_name()
  local bufname = vim.api.nvim_buf_get_name(0) -- 0 is the current buffer
  if bufname == "" then
    return "[No Name]"
  end
  return vim.fn.fnamemodify(bufname, ":t") -- Show only the filename, not full path
end

-- Set the winbar option globally or per window
vim.o.winbar = "%=%m " .. get_buffer_name() -- %m shows modified flag, %= right-aligns

-- Optional: Update winbar on buffer switch
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = function()
    vim.o.winbar = "%=%m " .. get_buffer_name()
  end,
})
