---@diagnostic disable: undefined-doc-name

local M = {}

---@alias utils.Action fun():boolean?
---@type table<string, utils.Action>
M.actions = {
  -- Native Snippets
  snippet_forward = function()
    if vim.snippet.active({ direction = 1 }) then
      vim.schedule(function()
        vim.snippet.jump(1)
      end)
      return true
    end
  end,
  snippet_stop = function()
    if vim.snippet then
      vim.snippet.stop()
    end
  end,
}

---@param actions string[]
---@param fallback? string|fun()
function M.map(actions, fallback)
  return function()
    for _, name in ipairs(actions) do
      if M.actions[name] then
        local ret = M.actions[name]()
        if ret then
          return true
        end
      end
    end
    return type(fallback) == "function" and fallback() or fallback
  end
end


function M.expand(snippet)
  -- Preserve the top-level snippet session
  local session = vim.snippet.active() and vim.snippet._session or nil

  -- Try expanding the snippet
  local ok, err = pcall(vim.snippet.expand, snippet)

  -- If expansion failed, try to fix it
  if not ok then
    local fixed = M.snippet_fix(snippet)
    ok = pcall(vim.snippet.expand, fixed)

    -- Notify the user of the error using vim.notify
    if not ok then
      vim.notify(
        "Failed to parse snippet: " .. err,
        vim.log.levels.ERROR,
        { title = "Snippet Expansion" }
      )
    else
      vim.notify(
        "Failed to parse snippet, but fixed automatically.",
        vim.log.levels.WARN,
        { title = "Snippet Expansion" }
      )
    end
  end

  -- Restore the top-level snippet session if needed
  if session then
    vim.snippet._session = session
  end
end

---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
M._supports_method = {}

---@param method string
---@param fn fun(client:vim.lsp.Client, buffer)
function M.on_supports_method(method, fn)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = "k" })
  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer ---@type number
      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

M.toggle_prefix = "<Leader>u"

M.toggle_keys = function(lhs, rhs, desc)
  vim.keymap.set("n", M.toggle_prefix .. lhs, function()
    local status_message = desc:gsub("^%S+%s+", "Toggled ")
    vim.notify(status_message, vim.log.levels.INFO)
    if type(rhs) == "string" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs, true, false, true), "n", false)
    else
      rhs()
    end
  end, { desc = desc })
end

M.foldexpr = function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("ministarter") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

M.on_very_lazy = function(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

M.pick = function(action, opts)
  opts = opts or {}
  return function()
    local cwd = opts.cwd or (opts.root and require("lazyvim.util").get_root()) or vim.fn.getcwd()
    require("fzf-lua")[action](vim.tbl_extend("force", opts, { cwd = cwd }))
  end
end


M.get_clients = function(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end


M.has = function(plugin)
  return M.get_plugin(plugin) ~= nil
end

M.icons = {
  misc = {
    dots = "󰇘",
  },
  ft = {
    octo = "",
  },
  dap = {
    Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint          = " ",
    BreakpointCondition = " ",
    BreakpointRejected  = { " ", "DiagnosticError" },
    LogPoint            = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
  },
  git = {
    added    = " ",
    modified = " ",
    removed  = " ",
  },
  kinds = {
    Array         = " ",
    Boolean       = "󰨙 ",
    Class         = " ",
    Codeium       = "󰘦 ",
    Color         = " ",
    Control       = " ",
    Collapsed     = " ",
    Constant      = "󰏿 ",
    Constructor   = " ",
    Copilot       = " ",
    Enum          = " ",
    EnumMember    = " ",
    Event         = " ",
    Field         = " ",
    File          = " ",
    Folder        = " ",
    Function      = "󰊕 ",
    Interface     = " ",
    Key           = " ",
    Keyword       = " ",
    Method        = "󰊕 ",
    Module        = " ",
    Namespace     = "󰦮 ",
    Null          = " ",
    Number        = "󰎠 ",
    Object        = " ",
    Operator      = " ",
    Package       = " ",
    Property      = " ",
    Reference     = " ",
    Snippet       = " ",
    String        = " ",
    Struct        = "󰆼 ",
    TabNine       = "󰏚 ",
    Text          = " ",
    TypeParameter = " ",
    Unit          = " ",
    Value         = " ",
    Variable      = "󰀫 ",
  },
}

---@generic T
---@param list T[]
---@return T[]
M.dedup = function(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

M.ai_indent = function(ai_type)
  local spaces = (" "):rep(vim.o.tabstop)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local indents = {} ---@type {line: number, indent: number, text: string}[]

  for l, line in ipairs(lines) do
    if not line:find("^%s*$") then
      indents[#indents + 1] = { line = l, indent = #line:gsub("\t", spaces):match("^%s*"), text = line }
    end
  end

  local ret = {} ---@type (Mini.ai.region | {indent: number})[]

  for i = 1, #indents do
    if i == 1 or indents[i - 1].indent < indents[i].indent then
      local from, to = i, i
      for j = i + 1, #indents do
        if indents[j].indent < indents[i].indent then
          break
        end
        to = j
      end
      from = ai_type == "a" and from > 1 and from - 1 or from
      to = ai_type == "a" and to < #indents and to + 1 or to
      ret[#ret + 1] = {
        indent = indents[i].indent,
        from = { line = indents[from].line, col = ai_type == "a" and 1 or indents[from].indent + 1 },
        to = { line = indents[to].line, col = #indents[to].text },
      }
    end
  end

  return ret
end

M.filterout_lua_diagnosing = function(notif_arr)
  local not_diagnosing = function(notif)
    return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
  end
  notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
  return MiniNotify.default_sort(notif_arr)
end

---@param name string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

M.opts = function(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

M.is_loaded = function(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

-- Utility from mini.statusline
M.isnt_normal_buffer = function()
  return vim.bo.buftype ~= ""
end

M.has_no_lsp_attached = function()
  return #vim.lsp.get_clients() == 0
end

M.get_filetype_icon = function()
  -- Have this `require()` here to not depend on plugin initialization order
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if not has_devicons then
    return ""
  end

  local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  return devicons.get_icon(file_name, file_ext, { default = true })
end

M.section_location = function(args)
  -- Use virtual column number to allow update when past last column
  if MiniStatusline.is_truncated(args.trunc_width) then
    return "%-2l│%-2v"
  end

  return "󰉸 %-2l│󱥖 %-2v"
end

M.section_filetype = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then
    return ""
  end

  local filetype = vim.bo.filetype
  if (filetype == "") or M.isnt_normal_buffer() then
    return ""
  end

  local icon = M.get_filetype_icon()
  if icon ~= "" then
    filetype = string.format("%s %s", icon, filetype)
  end

  return filetype
end

--- Section for current search count
---
--- Show the current status of |searchcount()|. Empty output is returned if
--- window width is lower than `args.trunc_width`, search highlighting is not
--- on (see |v:hlsearch|), or if number of search result is 0.
---
--- `args.options` is forwarded to |searchcount()|. By default it recomputes
--- data on every call which can be computationally expensive (although still
--- usually on 0.1 ms order of magnitude). To prevent this, supply
--- `args.options = { recompute = false }`.
M.section_searchcount = function(args)
  if vim.v.hlsearch == 0 then
    return ""
  end
  -- `searchcount()` can return errors because it is evaluated very often in
  -- statusline. For example, when typing `/` followed by `\(`, it gives E54.
  local ok, s_count = pcall(vim.fn.searchcount, (args or {}).options or { recompute = true })
  if not ok or s_count.current == nil or s_count.total == 0 then
    return ""
  end

  local icon = MiniStatusline.is_truncated(args.trunc_width) and "" or " "
  if s_count.incomplete == 1 then
    return icon .. "?/?│"
  end

  local too_many = (">%d"):format(s_count.maxcount)
  local current = s_count.current > s_count.maxcount and too_many or s_count.current
  local total = s_count.total > s_count.maxcount and too_many or s_count.total
  return ("%s%s/%s│"):format(icon, current, total)
end

M.section_buffers = function(args)
  local buffers = vim.fn.execute("ls")
  local count = 0
  for line in string.gmatch(buffers, "[^\r\n]+") do
    if string.match(line, "^%s*%d+") then
      count = count + 1
    end
  end
  if string.len(buffers) == 0 then
    -- print("No buffers found")
    return ""
  end

  local icon = MiniStatusline.is_truncated(args.trunc_width) and "" or " "
  -- local buf_count = #buffers

  return ("%s(%s)│"):format(icon, count)
end

M.section_pathname = function(args)
  args = vim.tbl_extend("force", {
    modified_hl = nil,
    filename_hl = nil,
    trunc_width = 80,
  }, args or {})

  if vim.bo.buftype == "terminal" then
    return "%t"
  end

  local path = vim.fn.expand("%:p")
  local cwd = vim.uv.cwd() or ""
  cwd = vim.uv.fs_realpath(cwd) or ""

  if path:find(cwd, 1, true) == 1 then
    path = path:sub(#cwd + 2)
  end

  local sep = package.config:sub(1, 1)
  local parts = vim.split(path, sep)
  if require("mini.statusline").is_truncated(args.trunc_width) and #parts > 3 then
    parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
  end

  local dir = ""
  if #parts > 1 then
    dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep
  end

  local file = parts[#parts]
  local file_hl = ""
  if vim.bo.modified and args.modified_hl then
    file_hl = "%#" .. args.modified_hl .. "#"
  elseif args.filename_hl then
    file_hl = "%#" .. args.filename_hl .. "#"
  end
  local modified = vim.bo.modified and " [+]" or ""
  return dir .. file_hl .. file .. modified
end

return M
