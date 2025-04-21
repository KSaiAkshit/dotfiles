return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",
    },
    -- keys = {
    --   { "<leader>gg", "<cmd>lua require('neogit').cwd()<CR>",                  desc = "Toggle [q]uickfix", },
    --   { "<leader>l", "<cmd>lua require('quicker').toggle({ loclist = true})<CR>", desc = "Toggle [l]oclist", },
    -- },
    config = true,

  },
}
