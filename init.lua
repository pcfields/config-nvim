require "pcfields.config.options"
require "pcfields.config.keymaps"
require "pcfields.config.plugins"
require "pcfields.plugins"


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.cmd("autocmd BufRead,BufEnter *.astro set filetype=astro")

vim.filetype.add({
  extension = {
      astro = "astro"
  }
})
