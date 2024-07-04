local M = {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    opts = {
      options = {
        relativenumber = false
      },
      plugins = {
        alacritty = {
          enabled = true,
          font = "12"
        },
        twilight = { enabled = false }
      }
    }
  }
}

return M
