---@diagnostic disable: undefined-global
local M = {
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf", "Trouble" },
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>D",  "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)", },
      { "<leader>d",  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)", },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)", },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)", },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)", },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(MiniBracketed.quickfix, "backward")
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(MiniBracketed.quickfix, "forward")
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    keys = {
      { "<leader>q", "<cmd>lua require('quicker').toggle()<CR>",                  desc = "Toggle [q]uickfix", },
      { "<leader>l", "<cmd>lua require('quicker').toggle({ loclist = true})<CR>", desc = "Toggle [l]oclist", },
    },
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand Quickfix context"
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse Quickfix context"
        },
      }
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPre",
    config = true,
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xx", "<cmd>TodoQuickFix<cr>",                             desc = "Todo (QuickFix)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    },
  },
  {
    "mbbill/undotree",
    event = "BufReadPre",
    cmd = "UndotreeToggle",
    keys = {
      {
        "<leader>uu",
        "<cmd>UndotreeToggle<cr>",
        desc = "Toggle Undotree",
      },
    },
  }
}

return M
