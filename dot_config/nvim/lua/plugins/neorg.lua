local M = {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    lazy = true,
    config = true
  },
  {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    ft = "norg",
    version = "*",
    dependencies = {
      "luarocks.nvim",
      "3rd/image.nvim"
    },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {
          config = {
            icon_preset = "varied"
          }
        }, -- Adds Pretty icons to docs
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = { extensions = "all" },
        },
        ["core.keybinds"] = {
          config = {
            defaul_keybinds = true,
            neorg_leader = "<Leader>n",
          },
        },
        ["core.dirman"] = {
          config = { -- Manages Neorg workspaces
            workspaces = {
              notes = "~/Documents/Notes/norg",
            },
            default_workspace = "notes",
            index = "index.norg",
          },
        },
        ["core.summary"] = {},
        ["core.journal"] = {
          config = { strategy = "flat", }
        },
        ["core.esupports.metagen"] = {
          config = {
            template = {
              { "title",      function() return vim.fn.expand("%:p:t:r") end },
              { "authors",    function() return os.getenv("USER") end },
              { "categories", "" },
              -- The tags are for the sake of obsidian
              { "tags",       "" },
              { "created",    function() return os.date '%d %b %Y %H:%M' end },
              { "updated",    function() return os.date '%d %b %Y %H:%M' end },
              { "version", function()
                local config = require("neorg.core.config")
                return config.norg_version
              end },
            }

          }
        }
      },
    },
  }
}

return M
