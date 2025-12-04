local augroup = vim.api.nvim_create_augroup('FiletypeSpecificTabs', { clear = true })
local patterns = { 'text' }
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = patterns,
  callback = function()
    vim.bo.expandtab = false
  end,
})
