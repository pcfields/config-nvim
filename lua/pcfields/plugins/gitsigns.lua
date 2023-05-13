-- https://github.com/lewis6991/gitsigns.nvim
-- Adds git releated signs to the gutter, as well as utilities for managing changes

require('gitsigns').setup {
    -- See `:help gitsigns.txt`
    signs = {
        add = {
            text = '+'
        },
        change = {
            text = '~'
        },
        delete = {
            text = '_'
        },
        topdelete = {
            text = '‾'
        },
        changedelete = {
            text = '~'
        }
    }
}
