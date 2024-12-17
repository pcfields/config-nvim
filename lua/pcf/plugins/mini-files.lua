-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
-- Navigate and manipulate file system

return {
    'echasnovski/mini.files',
    version = '*',
    config = function()
        local map = require('pcf.utils').map
        require('mini.files').setup {}

        map({ 'n', 'v' }, '<leader>fo', '<cmd>lua require("mini.files").open()<CR>', { desc = 'Open mini.files explorer' })
    end,
}
