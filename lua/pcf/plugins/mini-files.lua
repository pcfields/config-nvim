-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
-- Navigate and manipulate file system

return {
    'echasnovski/mini.files',
    version = '*',
    config = function()
        require('mini.files').setup()
    end,
}
