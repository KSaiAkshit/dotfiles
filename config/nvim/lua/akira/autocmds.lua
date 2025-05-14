-- MiniBasics Autocommands
local augroup = vim.api.nvim_create_augroup("MiniBasicsAutoCommands", {})

local au = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
end

-- Highlight yanked text for a while
au("TextYankPost", "*", function()
  vim.highlight.on_yank()
end, "Highlight yanked text")

-- Start terminal in insert mode
local start_terminal_insert = vim.schedule_wrap(function(data)
  if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == "terminal") then
    return
  end
  vim.cmd("startinsert")
end)
au("TermOpen", "term://*", start_terminal_insert, "Start builtin terminal in Inset mode")

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "lua OpenDiagnosticIfNoFloat()",
  group = "lsp_diagnostics_hold",
})

local function augrp(name)
  return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augrp("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "netrw",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "mininotify-history",
    "neotest-summary",
    "neotest-output-panel",
    "git",
    "Neogit",
    "Diffview"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local map = vim.keymap.set
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto Declaration" })
    map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Goto Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
    map("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "List Implementation" })
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "Add workspace folder" })
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "Remove workspace folder" })
    map("n", "<leader>cd", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Line Diagnostics" })
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = "List workspace folder" })
    map("n", "<leader>cD", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type definition" })
    map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code actions" })
    map("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Goto references" })
    -- map("n", "<leader>cf", function()
    --   vim.lsp.buf.format({ async = true })
    -- end, { buffer = ev.buf, desc = "Format" })
  end,
})
-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augrp("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
-- lsp signs
-- vim.api.nvim_create_autocmd({ "LspAttach" }, {
--   callback = function()
--     local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
--     vim.diagnostic.config({
--       signs = {
--         text = {
--           [vim.diagnostic.severity.ERROR] = signs.Error,
--           [vim.diagnostic.severity.WARN] = signs.Warn,
--           [vim.diagnostic.severity.HINT] = signs.Hint,
--           [vim.diagnostic.severity.INFO] = signs.INFO,
--         },
--         texthl = {
--           [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
--           [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
--           [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
--           [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
--         },
--         numhl = {
--           [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
--           [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
--           [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
--           [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
--         },
--       },
--     })
--   end,
-- })
-- FTP autocommands
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt.commentstring = "// %s"
  end,
})
