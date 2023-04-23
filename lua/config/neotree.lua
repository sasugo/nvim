local M = {}

function M.setup()
  require ("neo-tree").setup({
    window = {
      auto_expand_width = true,
      mappings = {
        ["o"]={
          "toggle_node",
          nowait = true
        },
      }
    },
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      filtered_items={
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true
      }
    },
    reveal = true,
    close_if_last_window = true,
    source_selector = {
      winbar = true,
      statusline = true
    }
  })
end

return M
