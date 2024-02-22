-- File that modifies existing plugins
M = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
  {
    "rcarriga/nvim-notify", -- Make notify window transparent
    opts = {
      background_colour = "#000000",
      timeout = 1000,
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false, mode = "i" } -- remove <C-k> in insert mode
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
  {
    {
      {
        "echasnovski/mini.comment",
        event = function(spec, old_events)
          local new_event = { "BufReadPre" }
          return new_event
        end,
      },
      "echasnovski/mini.pairs",
      event = function(spec, old_events)
        local new_event = { "BufReadPre" }
        return new_event
      end,
    },
    "echasnovski/mini.ai",
    event = function(spec, old_events)
      local new_event = { "BufReadPre" }
      return new_event
    end,
  },
  {
    "folke/flash.nvim", -- making it load on key press only
    event = function(spec, old_events)
      -- local new_event = { "BufReadPre" }
      local new_event = {}
      return new_event
    end,
  },
  {
    "echasnovski/mini.surround", -- Change surround keybindings
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "arduino-language-server", -- lsp for arduino
        "clangd", -- lsp for c/c++
        "cmakelang", -- lsp for cmake
        "cmakelint", -- linter for cmake
        "codelldb", -- Debugger for c/c++/rust
        "lua-language-server", -- Lua_ls
        "neocmakelsp", -- CMake
        "rust-analyzer", -- Rust
        "shfmt", -- Shell lsp
        "stylua", -- Lua formatter
        "taplo", -- TOML
        "marksman", -- Markdown
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    enabled = false
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
}

return M
