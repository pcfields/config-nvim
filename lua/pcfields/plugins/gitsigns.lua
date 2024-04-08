-- https://github.com/lewis6991/gitsigns.nvim
-- Adds git releated signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns.txt`

local map = require('pcfields.utils').map

local gitsigns = require('gitsigns')

gitsigns.setup {
    signs = {
        add = {
            text = '+',
        },
        change = {
            text = '~',
        },
        delete = {
            text = '_',
        },
        topdelete = {
            text = '‾',
        },
        changedelete = {
            text = '~',
        },
    },
    on_attach = function()
        -- Actions
        map('n', '<leader>gd', gitsigns.diffthis)
        map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end)
        map('n', '<leader>gbl', gitsigns.toggle_current_line_blame)
    end
}
