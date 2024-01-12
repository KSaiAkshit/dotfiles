vim.g.mapleader = ' '

local map = vim.keymap.set

-- Basic Maps
map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Add empty lines before and after cursor line supporting dot-repeat
map('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
map('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Copy/paste with system clipboard
map({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
map(  'n',        'gp', '"+p', { desc = 'Paste from system clipboard' })

-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map(  'x',        'gp', '"+P', { desc = 'Paste from system clipboard' })
-- Reselect latest changed, put, or yanked text
map('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map({ 'i', 'x', 'n', 's' }, '<C-S>', '<Cmd>silent! update | redraw<CR><Esc>', { desc = 'Save and go to Normal mode' })

-- Toggle prefix
local toggle_prefix = "<Leader>u"
local map_toggle = function(lhs, rhs, desc) map('n', toggle_prefix .. lhs, rhs, { desc = desc }) end -- Append 'toggle_prefix' to specified bindings

-- Toggle inlay hints
function Toggle_inlay_hints()
	local current_buffer = vim.fn.bufnr('%') -- get current buffer number
	local is_enabled = vim.lsp.inlay_hint.is_enabled(current_buffer) -- query the current state
	vim.lsp.inlay_hint.enable(current_buffer, not is_enabled)

	local status_message = is_enabled and "Inlay hints disabled" or "Inlay hints enabled"
	local id = MiniNotify.add(status_message, 'WARN', 'NotifyINFOTitle')
	vim.defer_fn(function() MiniNotify.remove(id) end, 1000)
end

-- Silent toggles
map_toggle('b', '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR>', "Toggle background")
map_toggle('c', '<Cmd>setlocal cursorline!<CR>',                                    "Toggle cursorline")
map_toggle('C', '<Cmd>setlocal cursorcolumn!<CR>',                                  "Toggle cursorcolumn")
map_toggle('d', '<Cmd>lua MiniBasics.toggle_diagnostic()<CR>',                      "Toggle diagnostic")
map_toggle('h', '<Cmd>let v:hlsearch = 1 - v:hlsearch<CR>',                         "Toggle search highlight")
map_toggle('i', '<Cmd>setlocal ignorecase!<CR>',                                    "Toggle ignorecase")
map_toggle('l', '<Cmd>setlocal list!<CR>',                                          "Toggle list")
map_toggle('n', '<Cmd>setlocal number!<CR>',                                        "Toggle number")
map_toggle('r', '<Cmd>setlocal relativenumber!<CR>',                                "Toggle relativenumber")
map_toggle('s', '<Cmd>setlocal spell!<CR>',                                         "Toggle spell")
map_toggle('w', '<Cmd>setlocal wrap!<CR>',                                          "Toggle wrap")
map_toggle('h', '<Cmd>lua Toggle_inlay_hints()<CR>',                                "Toggle wrap")

-- Window Mappings
map('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
map('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
map('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
map('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })

-- Move with <C-hjkl> in Insert and telescope
map('i', '<C-h>', '<Left>',  { noremap = false, desc = 'Left' })
map('i', '<C-j>', '<Down>',  { noremap = false, desc = 'Down' })
map('i', '<C-k>', '<Up>',    { noremap = false, desc = 'Up' })
map('i', '<C-l>', '<Right>', { noremap = false, desc = 'Right' })

map('t', '<C-h>', '<Left>',  { desc = 'Left' })
map('t', '<C-j>', '<Down>',  { desc = 'Down' })
map('t', '<C-k>', '<Up>',    { desc = 'Up' })
map('t', '<C-l>', '<Right>', { desc = 'Right' })

--Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" })

-- Advanced Maps
map('n', '<Tab>', '<cmd>bnext<CR>')
map('n', '<S-Tab>', '<cmd>bprev<CR>')
map('n', '<Leader>e', '<cmd>lua MiniFiles.open()<CR>', {desc = "[Mini.files] Find Files"})
map('n', '<F5>', '<cmd>lua MiniMap.toggle()<CR>')
map('n', '<Leader>z', '<cmd>lua MiniMisc.zoom()<CR>', {desc = "[Mini.misc] Zoom"})
map('n', '<', '<cmd>lua vim.diagnostic.open_float{focusable = false}<CR>')
map('n', '<Leader>bd', '<cmd>bdel<CR>')
map('n', '<Leader>ba', function() vim.ui.input({prompt = "New Buffer"}, function(input) vim.cmd({ cmd = 'badd', args = {input} }) end)end)
map('n', '<Leader>pf', '<cmd>Pick files<CR>', {desc = "[Mini.pick] Pick Files"})
map('n', '<Leader>pk', '<cmd>Pick keymaps<CR>', {desc = "[Mini.pick] Pick Keymaps"})
map('n', '<Leader>pp', function() vim.ui.select({
	'buf_lines',
	'buffers',
	'cli',
	'commands',
	'diagnostic',
	'explorer',
	'files',
	'git_branches',
	'git_commits',
	'git_files',
	'hit_hunks',
	'grep',
	'grep_live',
	'help',
	'hipatterns',
	'history',
	'hl_groups',
	'keymaps',
	'list',
	'lsp',
	'makrs',
	'oldfiles',
	'options',
	'registers',
	'resume',
	'spellsuggest',
	'treesitter'
},	{ prompt = "Pick " },
function(choice)
	return vim.cmd({ cmd = 'Pick', args = {choice}})
end)end, {desc = "[Mini.pick] Pick ..."})

-- FIXME:DOesn't work for now.. (see mini-modules/mini.base16)
-- vim.keymap.set('n', '<Leader>c', function() vim.ui.select({
	-- 	'oxocarbon',
	-- 	'kanagawa'
	-- }, { prompt = "Change base16 Colorscheme" },
	-- function(choice)
		-- 	return colorscheme == choice
		-- end)end)
