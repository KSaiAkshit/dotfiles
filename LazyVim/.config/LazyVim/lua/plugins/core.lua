M = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
}

return M
