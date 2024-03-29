-- Transparent background
-- vim.api.nvim_create_autocmd({ "" }, {
-- 	pattern = '*',
-- 	callback = function()
-- 		vim.api.nvim_command('highlight Normal guibg=none ctermbg=none')
-- 		vim.api.nvim_command('highlight NormalFloat guibg=none ctermbg=none')
-- 	end
-- })
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

local function augroup(name)
	return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
-- Automatically restart LSP after changin FQBN/Board
vim.api.nvim_create_autocmd('User', {
	pattern = 'ArduinoFqbnReset',
	callback = function()
		vim.cmd('LspRestart')
	end
})
-- lsp signs
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function()
		local signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
	end
})
-- FTP autocommands
vim.api.nvim_create_autocmd({ 'FileType'}, {
	pattern = {"c", "cpp"},
	callback = function ()
		vim.opt.commentstring = "// %s"
	end

	
})
