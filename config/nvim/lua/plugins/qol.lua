local M = {
  {
    "https://github.com/AndrewRadev/linediff.vim",
    lazy = true,
    cmd = "Linediff"
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      cmdline = {
        enabled = true,
      },
      lsp = {
        progress = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- requires hrsh7th/nvim-cmp
          ["cmp.entry.get_documentation"] = true,
        },
        message = { enabled = false },
      },
      messages = {
        enabled = false
      },
      notify = {
        enabled = false
      },
      presets = {
        lsp_doc_border = true,
        command_palette = true,
        bottom_search = true,
        long_message_to_split = true
      }
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = function()
      vim.keymap.set({ "n", "x" }, "<leader>re",
        function() return require('refactoring').refactor('Extract Function') end,
        { desc = "Extract Function", expr = true })
      vim.keymap.set({ "n", "x" }, "<leader>rf",
        function() return require('refactoring').refactor('Extract Function To File') end,
        { desc = 'Extract Function To File', expr = true })
      vim.keymap.set({ "n", "x" }, "<leader>rv",
        function() return require('refactoring').refactor('Extract Variable') end,
        { desc = 'Extract Variable', expr = true })
      vim.keymap.set({ "n", "x" }, "<leader>rI", function() return require('refactoring').refactor('Inline Function') end,
        { desc = 'Inline Function', expr = true })
      vim.keymap.set({ "n", "x" }, "<leader>ri", function() return require('refactoring').refactor('Inline Variable') end,
        { desc = 'Inline Variable', expr = true })

      vim.keymap.set({ "n", "x" }, "<leader>rbb", function() return require('refactoring').refactor('Extract Block') end,
        { desc = 'Extract Block', expr = true })
      vim.keymap.set({ "n", "x" }, "<leader>rbf",
        function() return require('refactoring').refactor('Extract Block To File') end,
        { desc = 'Extract Block To File', expr = true })
    end

  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      animate = { enabled = false },
      input = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
      { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
      { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd
        end,
      })
    end,
  },
}

return M
