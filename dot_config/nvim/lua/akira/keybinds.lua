vim.g.mapleader = " "

local map = vim.keymap.set

-- Basic Maps
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Add empty lines before and after cursor line supporting dot-repeat
map("n", "] ", "<Cmd>call append(line('.'),   repeat([''], v:count1))<CR>", { desc = "New line above" })
map("n", "[ ", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "New line below" })

-- Copy/paste with system clipboard
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "gp", '"+p', { desc = "Paste from system clipboard" })

-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "gp", '"+P', { desc = "Paste from system clipboard" })
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

-- -- Toggle prefix
-- local toggle_prefix = "<Leader>u"
-- local map_toggle = function(lhs, rhs, desc)
--   map("n", toggle_prefix .. lhs, rhs, { desc = desc })
-- end -- Append 'toggle_prefix' to specified bindings

local toggle_prefix = "<Leader>u"
-- Toggle prefix
local map_toggle = function(lhs, rhs, desc)
  map("n", toggle_prefix .. lhs, function()
    -- Extract everything after the first word
    local toggled_desc = desc:gsub("^%S+%s+", "Toggled ")
    local id = MiniNotify.add(toggled_desc, "INFO", "NotifyINFOTitle")
    vim.defer_fn(function()
      MiniNotify.remove(id)
    end, 1000)
    -- Check if rhs is a string or function
    if type(rhs) == "string" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs, true, false, true), 'n', false)
    else
      rhs() -- Execute the original function if rhs is a function
    end
  end, { desc = desc })
end

-- Toggle inlay hints
function Toggle_inlay_hints()
  local current_buffer = vim.fn.bufnr("%")                             -- get current buffer number
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ current_buffer }) -- query the current state
  vim.lsp.inlay_hint.enable(not is_enabled)

  local status_message = is_enabled and "Inlay hints disabled" or "Inlay hints enabled"
  local id = MiniNotify.add(status_message, "WARN", "NotifyINFOTitle")
  vim.defer_fn(function()
    MiniNotify.remove(id)
  end, 1000)
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

-- Silent toggles
map_toggle("b", '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR>', "Toggle background")
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
map("n", "<Leader>gh", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "[Mini.diff] Toggle hunks" })

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
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Advanced Maps
map("n", "<Leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "[Mini.files] Find Files" })
map("n", "<F5>", "<cmd>lua MiniMap.toggle()<CR>")
map("n", "<Leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle [Z]enMode" })
map("n", "<Leader>bd", "<cmd>bdel<CR>", { desc = "[D]elete Current Buffer" })
map("n", "<Leader>ba", function()
  vim.ui.input({ prompt = "New Buffer" }, function(input)
    vim.cmd({ cmd = "badd", args = { input } })
  end)
end, { desc = "[A]dd New Buffer" })
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

-- Lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto Declaration" })
    map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Goto Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
    map("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "List Implementation" })
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "Add workspace folder" })
    map(
      "n",
      "<leader>wr",
      vim.lsp.buf.remove_workspace_folder,
      { buffer = ev.buf, desc = "Remove workspace folder" }
    )
    map("n", "<leader>cd", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Line Diagnostics" })
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = "List workspace folder" })
    map("n", "<leader>cD", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type definition" })
    map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code actions" })
    map("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Goto references" })
    map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = ev.buf, desc = "Format" })
  end,
})
