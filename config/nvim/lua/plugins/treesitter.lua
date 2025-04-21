local utils = require("akira.utils")
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = "BufReadPre",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      textobjects = {
        select = { enable = false },
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[A"] = "@parameter.inner" },
        },

      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = utils.dedup(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
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
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPre",
    config = function()
      -- If treesitter is already loaded, we need to run config again for textobjects
      if utils.is_loaded("nvim-treesitter") then
        local opts = utils.opts("nvim-treesitter")
        require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
      end

      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  }
}
