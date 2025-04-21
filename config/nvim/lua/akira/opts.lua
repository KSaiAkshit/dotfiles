--
local o, opt = vim.opt, vim.opt

-- Leader key
if vim.g.mapleader == nil then
  vim.g.mapleader = " " -- Use space as the one and only true Leader key
end

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- General
o.undofile = true     -- Enable persistent undo (see also `:h undodir`)

o.backup = false      -- Don't store backup while overwriting the file
o.writebackup = false -- Don't store backup while overwriting the file

o.mouse = "a"         -- Enable mouse for all available modes

-- Appearance
o.breakindent = true    -- Indent wrapped lines to match line start
o.cursorline = true     -- Highlight current line
o.cursorcolumn = true   -- Highlight current line
o.linebreak = true      -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.number = true         -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.splitbelow = true     -- Horizontal splits will be below
o.splitright = true     -- Vertical splits will be to the right

o.ruler = false         -- Don't show cursor position in command line
o.showmode = false      -- Don't show mode in command line
o.wrap = false          -- Display long lines as just one line

o.signcolumn = "yes"    -- Always show sign column (otherwise it will shift text)
-- Don't show `~` outside of buffer
o.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = "·",
  foldsep = "│",
  diff = "╱",
  eob = " ",
}

o.scrolloff = 15
o.tabstop = 2
o.shiftwidth = 2
o.conceallevel = 3
o.expandtab = true

o.relativenumber = true
o.number = true
o.cmdheight = 1

-- Editing
o.ignorecase = true                         -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch = true                          -- Show search results while typing
o.infercase = true                          -- Infer letter cases for a richer built-in keyword completion
o.smartcase = true                          -- Don't ignore case when searching if pattern has upper case
o.smartindent = true                        -- Make indenting smart
o.inccommand = "split"                      -- Preview substitutions live, as you type!

o.completeopt = "menuone,noinsert,noselect" -- Customize completions
o.virtualedit = "block"                     -- Allow going past the end of line in visual block mode
o.formatoptions = "qjl1"                    -- Don't autoformat comments
o.updatetime = 100                          -- Decrease update time
o.timeoutlen = 300                          -- Decrease wait time for key seq
o.smoothscroll = true                       -- Enable smoothscroll

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Folds
o.foldexpr = "v:lua.require'akira.utils'.foldexpr()" -- Let treesitter handle foldexpr
o.foldmethod = "expr"                                -- Choose method for defining folds
o.foldlevelstart = -1                                -- Start with all folds closed
o.foldlevel = 99                                     -- Set highest fold level to close all folds to the deepest lvl
o.foldtext = ""

opt.shortmess:append("WcC") -- Reduce command line messages
o.splitkeep = "screen"      -- Reduce scroll during window split

o.termguicolors = true      -- Enable gui colors

-- Extra UI options
o.pumblend = 10  -- Make builtin completion menus slightly transparent
o.pumheight = 10 -- Make popup menu smaller
o.winblend = 0   -- Make floating windows transparent

-- NOTE: Having `tab` present is needed because `^I` will be shown if
-- omitted (documented in `:h listchars`).
-- Having it equal to a default value should be less intrusive.
o.listchars = "tab:> ,extends:…,precedes:…,nbsp:␣" -- Define which helper symbols to show
o.list = true -- Show some helper symbols

-- Enable syntax highlighting if it wasn't already (as it is time consuming)
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd([[syntax enable]])
end

function OpenDiagnosticIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    local config = vim.api.nvim_win_get_config(winid)
    if config.relative ~= '' then
      return
    end
  end
  -- This is for builtin LSP
  vim.diagnostic.open_float(0, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end
