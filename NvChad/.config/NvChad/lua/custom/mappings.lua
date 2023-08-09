local M = {}

M.disabled = {
  n = {
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
    ["<C-H>"] = "",
    ["<C-J>"] = "",
    ["<C-K>"] = "",
    ["<C-L>"] = "",
    ["<C-y>"] = "",
  }
}

M.custom = {
  i = {
    ["jj"] = {"<Esc>", "escape insert mode", opts = {nowait = true}},
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function ()
        require('dap-python').test_method()
      end,
      "Python DAP test"
    }
  }
}

M.tmux = {
  n = {
    ["<C-h"] = {"<cmd>lua require('tmux').move_left()<cr>", "Shift focus left"},
    ["<C-j"] = {"<cmd>lua require('tmux').move_bottom()<cr>", "Shift focus down"},
    ["<C-k"] = {"<cmd>lua require('tmux').move_top()<cr>", "Shift focus up"},
    ["<C-l"] = {"<cmd>lua require('tmux').move_right()<cr>", "Shift focus right"},
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}

return M
