local M = {
  "m4xshen/hardtime.nvim",
  event = "BufEnter",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    max_count = 5,
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "norg", "minifiles" },
  },

  keys = {
    {
      "<leader>ua",
      "<cmd>Hardtime toggle<cr>",
      desc = "Toggle Hardtime",
    },
  },
}

return M
