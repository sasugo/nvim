local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

local M = {}

function M.setup()
  -- Setup with some options
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
      update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    actions = {
      open_file = {
        resize_window = true
      },
    },
    renderer = {
      group_empty = true,
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    filters = {
      dotfiles = false
    },
  })
  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
end

return M
