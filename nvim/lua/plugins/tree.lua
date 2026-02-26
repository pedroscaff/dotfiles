return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local config = {
      update_focused_file = {
        enable = true,
      }
    }
    require("nvim-tree").setup(config)
  end,
}
