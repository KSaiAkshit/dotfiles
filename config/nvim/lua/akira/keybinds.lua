if vim.g.mapleader == nil then
  vim.g.mapleader = ' ' -- Use space as the one and only true Leader key
end

local map = vim.keymap.set

-- Basic Maps
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Auto center on large jumps
map({ "n", "x"}, "<C-d>", "<C-d>zz", { desc = "Half-Page-Down", silent = true })
map({ "n", "x"}, "<C-u>", "<C-u>zz", { desc = "Half-Page-Up", silent = true })
map({ "n", "x"}, "<C-f>", "<C-f>zz", { desc = "Page-Down", silent = true })
map({ "n", "x"}, "<C-b>", "<C-b>zz", { desc = "Page-Up", silent = true })

-- Add empty lines before and after cursor line supporting dot-repeat
map("n", "[ ", "<Cmd>call append(line('.') - 1,   repeat([''], v:count1))<CR>", { desc = "New line above" })
map("n", "] ", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "New line below" })


-- Copy/paste with system clipboard
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "x" }, "gp", '"+P', { desc = "Paste from system clipboard" })

-- Reselect latest changed, put, or yanked text
map(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map({ "i", "x", "n", "s" }, "<C-S>", "<Cmd>silent! update | redraw<CR><Esc>", { desc = "Save and go to Normal mode" })

-- Append 'toggle_prefix' to specified bindings
local toggle_prefix = "<Leader>u"
-- Toggle prefix
local map_toggle = function(lhs, rhs, desc)
  map("n", toggle_prefix .. lhs, function()
    local status_message = desc:gsub("^%S+%s+", "Toggled ")
    vim.notify(status_message, vim.log.levels.INFO)
    if type(rhs) == "string" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs, true, false, true), "n", false)
    else
      rhs()
    end
  end, { desc = desc })
end

-- Toggle inlay hints
function Toggle_inlay_hints()
  local current_buffer = vim.fn.bufnr("%")                             -- get current buffer number
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ current_buffer }) -- query the current state
  vim.lsp.inlay_hint.enable(not is_enabled)
end

local diagnostics_active = true
function Toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

function Toggle_virtual_text()
  local curr_state = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not curr_state
  })
end

function Toggle_tabline()
  local curr_state = vim.g.minitabline_disable
  if curr_state == nil then
    vim.g.minitabline_disable = true
  else
    vim.g.minitabline_disable = nil
  end
end

-- Silent toggles
map_toggle("c", "<Cmd>setlocal cursorline!<CR>", "Toggle cursorline")
map_toggle("C", "<Cmd>setlocal cursorcolumn!<CR>", "Toggle cursorcolumn")
map_toggle("h", "<Cmd>let v:hlsearch = 1 - v:hlsearch<CR>", "Toggle search highlight")
map_toggle("i", "<Cmd>setlocal ignorecase!<CR>", "Toggle ignorecase")
map_toggle("l", "<Cmd>setlocal list!<CR>", "Toggle list")
map_toggle("n", "<Cmd>setlocal number!<CR>", "Toggle number")
map_toggle("r", "<Cmd>setlocal relativenumber!<CR>", "Toggle relativenumber")
map_toggle("s", "<Cmd>setlocal spell!<CR>", "Toggle spell")
map_toggle("w", "<Cmd>setlocal wrap!<CR>", "Toggle wrap")
map_toggle("h", "<Cmd>lua Toggle_inlay_hints()<CR>", "Toggle inlay hints")
map_toggle("d", "<Cmd>lua Toggle_diagnostics()<CR>", "Toggle diagnostics")
map_toggle("v", "<Cmd>lua Toggle_virtual_text()<CR>", "Toggle virtual text")
map_toggle("b", "<Cmd>lua Toggle_tabline()<CR>", "Toggle tabline")
map("n", "<Leader>gh", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "[Mini.diff] Toggle diff" })

-- Window Mappings
map("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
map("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
map("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
map("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })

-- Move with <C-hjkl> in Insert and telescope
map("i", "<C-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<C-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<C-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<C-l>", "<Right>", { noremap = false, desc = "Right" })

map("t", "<C-h>", "<Left>", { desc = "Left" })
map("t", "<C-j>", "<Down>", { desc = "Down" })
map("t", "<C-k>", "<Up>", { desc = "Up" })
map("t", "<C-l>", "<Right>", { desc = "Right" })

--Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>uR",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "<Leader>xp", function()
  local root = Snacks.git.get_root()
  vim.cmd("TodoQuickFix cwd=" .. root)
end)

-- Advanced Maps
map("n", "<Leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "[Mini.files] Find Files" })
map("n", "<Leader>bd", "<cmd>lua MiniBufremove.delete()<CR>", { desc = "[D]elete Current Buffer" })
map("n", "<Leader>ba", function()
  vim.ui.input({ prompt = "New Buffer" }, function(input)
    vim.cmd({ cmd = "badd", args = { input } })
  end)
end, { desc = "[A]dd New Buffer" })
map("n", "<Leader>gq", "<cmd>lua vim.fn.setqflist(MiniDiff.export('qf'))<CR>", { desc = "Git [q]uickfixlist" })
map("n", "<leader>gs", ":Git status<CR>", { desc = "Git status" })
map("n", "<Leader><Leader>", "<cmd>Pick files<CR>", { desc = "[Mini.pick] Pick Files" })
map("n", "<Leader>pk", "<cmd>Pick keymaps<CR>", { desc = "[Mini.pick] Pick Keymaps" })
map("n", "<Leader>pp", function()
  vim.ui.select({
    "buf_lines",
    "buffers",
    "cli",
    "commands",
    "diagnostic",
    "explorer",
    "files",
    "git_branches",
    "git_commits",
    "git_files",
    "git_hunks",
    "grep",
    "grep_live",
    "help",
    "hipatterns",
    "history",
    "hl_groups",
    "keymaps",
    "list",
    "lsp",
    "marks",
    "oldfiles",
    "options",
    "registers",
    "resume",
    "spellsuggest",
    "treesitter",
  }, { prompt = "Pick " }, function(choice)
    return vim.cmd({ cmd = "Pick", args = { choice } })
  end)
end, { desc = "[Mini.pick] Pick ..." })
