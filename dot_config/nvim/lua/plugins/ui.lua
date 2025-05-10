return {
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        styles = {
          transparency = true
        },
        highlight_groups = {
          TreesitterContext = { bg = "NONE" },
          TreesitterContextLineNumber = { bg = "NONE" }
        }
      })
      local palette = require("rose-pine.palette")
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {
    "stevearc/dressing.nvim",
    config = true,
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}
