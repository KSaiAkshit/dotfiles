-- Neorg doesn't support vimtex injection for math blocks, soooo bye-bye for now.
M = {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    ft = "norg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds Pretty icons to docs
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = { extensions = "all" },
          },
          ["core.keybinds"] = {
            config = {
              defaul_keybinds = true,
              neorg_leader = "<LocalLeader>",
            },
          },
          ["core.dirman"] = {
            config = { -- Manages Neorg workspaces
              workspaces = {
                notes = "~/Documents/Notes",
              },
              default_workspace = "notes",
              index = "index.norg",
            },
          },
        },
      })
    end,
  },
}

return M
