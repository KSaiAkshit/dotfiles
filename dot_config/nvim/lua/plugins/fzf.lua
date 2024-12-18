local utils = require("akira.utils")

local M = {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function(_, opts)
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Trouble
    if utils.has("trouble.nvim") then
      config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
    end

    -- Toggle root dir / cwd
    config.defaults.actions.files["ctrl-r"] = function(_, ctx)
      local opt = vim.deepcopy(ctx.__call_opts)
      opt.root = not opts.root
      opt.cwd = opts.root and vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
      require("fzf-lua").files(opt)
    end
    config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa",    args = { "{file}", "--format=symbols" } },
      { cmd = "viu",      args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      "default-title",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(utils.get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["ctrl-g"] = false,
          ["ctrl-i"] = { actions.toggle_ignore },
        },
      },
      grep = {
        actions = {
          ["ctrl-g"] = false,
          ["ctrl-i"] = { actions.toggle_ignore },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    }
  end,
  config = function(_, opts)
    if opts[1] == "default-title" then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,
  init = function()
    utils.on_very_lazy(function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        local opts = utils.opts("fzf-lua") or {}
        require("fzf-lua").register_ui_select(opts.ui_select or nil)
        return vim.ui.select(...)
      end
    end)
  end,
  keys = {
    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    {
      "<leader>,",
      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>/",       utils.pick("live_grep"),                                    desc = "Grep (Root Dir)" },
    { "<leader>:",       "<cmd>FzfLua command_history<cr>",                          desc = "Command History" },
    { "<leader><space>", utils.pick("files"),                                        desc = "Find Files (Root Dir)" },
    -- find
    { "<leader>fb",      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>ff",      utils.pick("files"),                                        desc = "Find Files (Root Dir)" },
    { "<leader>fF",      utils.pick("files", { root = false }),                      desc = "Find Files (cwd)" },
    { "<leader>fg",      "<cmd>FzfLua git_files<cr>",                                desc = "Find Files (git-files)" },
    { "<leader>fr",      "<cmd>FzfLua oldfiles<cr>",                                 desc = "Recent" },
    { "<leader>fR",      utils.pick("oldfiles", { cwd = vim.uv.cwd() }),             desc = "Recent (cwd)" },
    -- git
    { "<leader>gc",      "<cmd>FzfLua git_commits<CR>",                              desc = "Commits" },
    { "<leader>gs",      "<cmd>FzfLua git_status<CR>",                               desc = "Status" },
    -- search
    { '<leader>s"',      "<cmd>FzfLua registers<cr>",                                desc = "Registers" },
    { "<leader>sa",      "<cmd>FzfLua autocmds<cr>",                                 desc = "Auto Commands" },
    { "<leader>sb",      "<cmd>FzfLua grep_curbuf<cr>",                              desc = "Buffer" },
    { "<leader>sc",      "<cmd>FzfLua command_history<cr>",                          desc = "Command History" },
    { "<leader>sC",      "<cmd>FzfLua commands<cr>",                                 desc = "Commands" },
    { "<leader>sd",      "<cmd>FzfLua diagnostics_document<cr>",                     desc = "Document Diagnostics" },
    { "<leader>sD",      "<cmd>FzfLua diagnostics_workspace<cr>",                    desc = "Workspace Diagnostics" },
    { "<leader>sg",      utils.pick("live_grep"),                                    desc = "Grep (Root Dir)" },
    { "<leader>sG",      utils.pick("live_grep", { root = false }),                  desc = "Grep (cwd)" },
    { "<leader>sh",      "<cmd>FzfLua help_tags<cr>",                                desc = "Help Pages" },
    { "<leader>sH",      "<cmd>FzfLua highlights<cr>",                               desc = "Search Highlight Groups" },
    { "<leader>sj",      "<cmd>FzfLua jumps<cr>",                                    desc = "Jumplist" },
    { "<leader>sk",      "<cmd>FzfLua keymaps<cr>",                                  desc = "Key Maps" },
    { "<leader>sl",      "<cmd>FzfLua loclist<cr>",                                  desc = "Location List" },
    { "<leader>sM",      "<cmd>FzfLua man_pages<cr>",                                desc = "Man Pages" },
    { "<leader>sm",      "<cmd>FzfLua marks<cr>",                                    desc = "Jump to Mark" },
    { "<leader>sR",      "<cmd>FzfLua resume<cr>",                                   desc = "Resume" },
    { "<leader>sq",      "<cmd>FzfLua quickfix<cr>",                                 desc = "Quickfix List" },
    { "<leader>sw",      utils.pick("grep_cword"),                                   desc = "Word (Root Dir)" },
    { "<leader>sW",      utils.pick("grep_cword", { root = false }),                 desc = "Word (cwd)" },
    { "<leader>sw",      utils.pick("grep_visual"),                                  mode = "v",                       desc = "Selection (Root Dir)" },
    { "<leader>sW",      utils.pick("grep_visual", { root = false }),                mode = "v",                       desc = "Selection (cwd)" },
    { "<leader>uC",      utils.pick("colorschemes"),                                 desc = "Colorscheme with Preview" },
    {
      "<leader>ss",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("fzf-lua").lsp_live_workspace_symbols()
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
}
return M
