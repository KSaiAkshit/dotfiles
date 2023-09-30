M = {
  {
    "nvim-orgmode/orgmode",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "org" },
    opts = function()
      require("orgmode").setup_ts_grammar()
    end,
    config = function()
      -- require("nvim-treesitter.configs").setup({
      --   highlight = {
      --     enable = true,
      --     additional_vim_regex_highlighting = { "org" },
      --   },
      --   ensure_installed = { "org" },
      -- })
      require("orgmode").setup({
        org_highlight_latex_and_reloated = "entity",
      })
      -- require("orgmode").setup_ts_grammer()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "org",
      })
    end,
  },
}

return M
