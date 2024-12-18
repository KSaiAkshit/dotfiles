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
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3 }
    end,
  }
}
