local client = vim.lsp.start_client({
  name = 'rustylsp',
  cmd = { '/home/akira/dev/oxide/rustylsp/target/debug/rustylsp' },
  -- cmd = { '/home/akira/temp/educationalsp/main' },
  root_dir = vim.fs.root(0, { 'Cargo.toml' }),
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = "markdown",
  callback = function(arg)
    vim.lsp.buf_attach_client(0, client)
  end,
})
