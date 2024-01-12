-- Transparent background
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = '*',
	callback = function()
		vim.api.nvim_command('highlight Normal guibg=none ctermbg=none')
		vim.api.nvim_command('highlight NormalFloat guibg=none ctermbg=none')
	end
})

-- MiniBasics Autocommands
local augroup = vim.api.nvim_create_augroup('MiniBasicsAutoCommands', {})

local au = function(event, pattern, callback, desc)
	vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
end

-- Highlight yanked text for a while
au('TextYankPost', '*', function() vim.highlight.on_yank() end, 'Highlight yanked text')

-- Start terminal in insert mode
local start_terminal_insert = vim.schedule_wrap(function(data)
	if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then return end
	vim.cmd('startinsert')
end)
au('TermOpen', 'term://*', start_terminal_insert, 'Start builtin terminal in Inset mode')

-- Show relativenumbers only when they matter
au(
	'ModeChanged',
	'*:[V\x16]*',
	function() vim.wo.relativenumber = vim.wo.number end,
	'Show relative numbers'
)
au(
	'ModeChanged',
	'[V\x16]*:*',
	-- Hide relative numbers when neither linewise/blockwise mode is on
	function() vim.wo.relativenumber = string.find(vim.fn.mode(), '^[V\22]') ~= nil end,
	'Hide relative line numbers'
)
-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
   command = "lua OpenDiagnosticIfNoFloat()",
   group = "lsp_diagnostics_hold",
})

