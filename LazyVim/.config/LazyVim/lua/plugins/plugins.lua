M = {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_background = true,
      disable_float_background = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    dependecies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local ts_context = require("treesitter-context")
      ts_context.setup({
        enable = true,
        max_lines = 0, -- How many lines the window should span, Value <=0 is no limit
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      })
    end,
  },
}

return M
