local M = {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "[Harpoon] File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "[Harpoon] Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "[Harpoon] File " .. i,
        })
      end
      return keys
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    lazy = true,
    ft = { "qf", "Trouble" },
    dependencies = {
      "junegunn/fzf",
    },
    opts = {
      preview = {
        winblend = 0,
      },
      filter = {
        fzf = {
          extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│' }
        }
      }
    }
  },
  {
    "junegunn/fzf",
    lazy = true,
    dir = "~/.fzf",
    build = "./install --all"
  },
  {
    "stevearc/quicker.nvim",
    ft = { "qf", "Trouble" },
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
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>D", "<cmd>Trouble diagnostics toggle<cr>", desc = "[Trouble] Diagnostics" },
      {
        "<leader>d",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "[Trouble] Buffer Diagnostics",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "[Trouble] LSP Definitions / references / ...",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(MiniBracketed.quickfix, 'backward')
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
            local ok, err = pcall(MiniBracketed.quickfix, 'forward')
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    opts = {
      focus = true,
    }, -- for default options, refer to the configuration section for custom setup.
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble" },
    event = "BufReadPre",
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",  desc = "Todo (Trouble)" },
      { "<leader>xX", "<cmd>TodoQuickFix<cr>", desc = "Todo (QuickFix)" },
      {
        "<leader>xx",
        function()
          local dir = Snacks.git.get_root()
          vim.cmd("TodoQuickFix cwd=" .. dir)
        end,
        desc = "Todo Project (QuickFix)"
      },
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
  },
}

return M
