local utils = require("akira.utils")
return {
  "echasnovski/mini.nvim",
  config = function()
    local ai = require("mini.ai")
    require("mini.ai").setup({
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
        d = { "%f[%d]%d+" },                                                          -- digits
        e = {                                                                         -- Word with case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        k = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- comment
        i = utils.ai_indent,                                                        -- indent
        g = require("mini.extra").gen_ai_spec.buffer(),                             -- buffer
        u = require("mini.ai").gen_spec.function_call(),                            -- u for "Usage"
        U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }),  -- without dot in function name
      }
    })
    require("mini.align").setup()
    require("mini.bracketed").setup({
      comment = { suffix = "k" },
      file = { suffix = "" },
    })
    require("mini.bufremove").setup()
    local miniclue = require("mini.clue")

    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        -- `[` `]` brackets from mini.bracketed
        { mode = "n", keys = "[" },
        { mode = "x", keys = "[" },

        { mode = "n", keys = "]" },
        { mode = "x", keys = "]" },

        -- `d` key
        { mode = "n", keys = "d" },
        { mode = "x", keys = "d" },
        { mode = "v", keys = "d" },

        -- `c` key
        { mode = "n", keys = "c" },
        { mode = "x", keys = "c" },
        { mode = "v", keys = "c" },

        -- `s` key from mini.surround
        { mode = "v", keys = "s" },
        { mode = "n", keys = "s" },
      },

      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        -- Enhance this by adding descriptions for <Leader> mapping groups
        { mode = "n", keys = "<Leader>f",  desc = "+find" },
        { mode = "n", keys = "<Leader>c",  desc = "+code" },
        { mode = "n", keys = "<Leader>s",  desc = "+search" },
        { mode = "n", keys = "<Leader>p",  desc = "+Pick" },
        { mode = "n", keys = "<Leader>b",  desc = "+buffer" },
        { mode = "n", keys = "<Leader>g",  desc = "+git" },
        { mode = "n", keys = "<Leader>u",  desc = "+ui" },
        { mode = "n", keys = "<Leader>w",  desc = "+workspace" },
        { mode = "n", keys = "<Leader>n",  desc = "+neorg" },
        { mode = "n", keys = "<Leader>ni", desc = "+insert" },
        { mode = "n", keys = "<Leader>nl", desc = "+list" },
        { mode = "n", keys = "<Leader>nm", desc = "+mode" },
        { mode = "n", keys = "<Leader>nn", desc = "+new" },
        { mode = "n", keys = "<Leader>nt", desc = "+todo" },
        { mode = "n", keys = "<Leader>x",  desc = "+trouble" },
        { mode = "n", keys = "<Leader>r",  desc = "+refactor" },
      },
      window = {
        -- Show window immediately
        delay = 50,
        config = {
          width = "50",
        },
      },
    })
    require("mini.comment").setup()

    vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
    vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

    vim.api.nvim_set_keymap("i", "<Down>", [[pumvisible() ? "<C-o>j" : "\<Down>"]], { expr = true, noremap = true })
    vim.api.nvim_set_keymap("i", "<Up>", [[pumvisible() ? "<C-o>k" : "\<Up>"]], { expr = true, noremap = true })
    require("mini.cursorword").setup()
    require("mini.doc").setup()
    require("mini.diff").setup({
      view = {
        style = "sign",
        signs = {
          add = "│",
          change = "│",
          delete = "",
        },
      },
    })
    require("mini.extra").setup()
    require("mini.files").setup()
    require("mini.fuzzy").setup()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
    require("mini.git").setup()
    require("mini.icons").setup()
    ---@diagnostic disable-next-line: undefined-global
    MiniIcons.mock_nvim_web_devicons()
    require("mini.indentscope").setup({
      delay = 10,
      symbol = "│", -- Character is called BOX DRAWING LEFT VERTICAL
    })
    require("mini.jump").setup()
    require("mini.jump2d").setup({
      view = {
        dim = true
      },
      mappings = {
        start_jumping = "gw",
      },
    })
    require("mini.misc").setup()
    require("mini.move").setup({
      mappings = {
        -- Visual Mode
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
      },
    })
    require("mini.notify").setup({
      content = { sort = utils.filterout_lua_diagnosing },
      window = { max_width_share = 0.75, config = { border = "single" }, winblend = 0 },
    })
    ---@diagnostic disable-next-line: undefined-global
    vim.notify = MiniNotify.make_notify()
    require("mini.operators").setup({
      evaluate = {
        prefix = 'g=',
      },
      exchange = {
        prefix = '',
      },

      multiply = {
        prefix = 'gm',
      },

      replace = {
        prefix = '',
      },

      sort = {
        prefix = 'gs',
      }
    })
    require("mini.pairs").setup()
    require("mini.pick").setup()
    require("mini.sessions").setup({
      autoread = false,
      autowrite = true,
    })
    require("mini.splitjoin").setup()
    require("mini.starter").setup()
    require("mini.statusline").setup({
      use_icons = true,
      content = {
        inactive = function()
          local pathname = utils.section_pathname({ trunc_width = 120 })
          return MiniStatusline.combine_groups({
            { hl = "MiniStatuslineInactive", strings = { pathname } }
          })
        end,
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git           = MiniStatusline.section_git({ trunc_width = 40 })
          local diff          = MiniStatusline.section_diff({ trunc_width = 120 })
          local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 60 })
          local lsp           = MiniStatusline.section_lsp({ trunc_width = 40 })
          local filetype      = utils.section_filetype({ trunc_width = 70 })
          local location      = utils.section_location({ trunc_width = 120 })
          local search        = utils.section_searchcount({ trunc_width = 80 })
          local buffers       = utils.section_buffers({ trunc_width = 80 })
          local pathname      = utils.section_pathname({
            trunc_width = 120,
            filename_hl = "MiniStatuslineFilename",
            modified_hl = "MiniStatuslineFilenameModified"
          })

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                 strings = { mode:upper() } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineDirectory', strings = { pathname } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo',  strings = { filetype, diagnostics, lsp } },
            { hl = mode_hl,                   strings = { search .. buffers .. location } },
          })
        end
      }
    })
    require("mini.surround").setup()
    require("mini.tabline").setup({
      tabpage_section = "right"
    })
    require("mini.trailspace").setup()
    require("mini.visits").setup()
  end,
}
