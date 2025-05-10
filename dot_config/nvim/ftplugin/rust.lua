
local palette = require("rose-pine.palette")
vim.api.nvim_set_hl(0, "@lsp.type.macro.rust", {fg = palette.rose, italic = true})
vim.api.nvim_set_hl(0, "@lsp.type.namespace.rust", {fg = palette.text, italic = true})
vim.api.nvim_set_hl(0, "@lsp.type.enumMember.rust", {fg = palette.foam, italic = true})
