return {
  "nvim-telescope/telescope.nvim",
  version      = "*",
  cmd          = "Telescope",
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy         = true,
  keys         = {
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>/",  "<cmd>Telescope live_grep<cr>",                                desc = "Grep" },
    { "<leader>:",  "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
    -- find
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                               desc = "Find Files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent" },
    -- { "<leader><leader>", "<cmd>Telescope git_files<cr>",                                desc = "Recent" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<cr>",                              desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>",                               desc = "status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>",                                desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>",                             desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                                 desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",                      desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                              desc = "Workspace diagnostics" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>",                                desc = "Grep (root dir)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>",                               desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                  desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                                    desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>",                              desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>",                                   desc = "Resume" },
    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>",                     desc = "Goto Symbol", },
    { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",            desc = "Goto Symbol (Workspace)", },
    {
      "<leader>sw",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      desc = "Grep string",
    },
  },
  opts         = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },

    extensions_list = { "themes", "terms" },
  }
}
