local utils = require("akira.utils")
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        highlight = {
          enable = true
        },
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPre",
    config = function()
      if utils.is_loaded("nvim-treesitter") then
        local opts = utils.opts("nvim-treesitter")
        require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
      end
    end
  }
}
