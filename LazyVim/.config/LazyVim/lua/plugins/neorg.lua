M = {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    event = "VeryLazy",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds Pretty icons to docs
          ["core.export"] = {},
          ["core.keybinds"] = {},
          ["core.dirman"] = {
            config = { -- Manages Neorg workspaces
              workspaces = {
                notes = "~/.notes",
              },
            },
          },
        },
      })
    end,
  },
}

return M
