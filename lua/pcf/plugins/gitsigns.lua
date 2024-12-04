-- https://github.com/lewis6991/gitsigns.nvim
-- adds git releated signs to the gutter, as well as utilities for managing changes
-- see `:help gitsigns.txt`

local map = require('pcf.utils').map
local gitsigns = require 'gitsigns'

return {
    'lewis6991/gitsigns.nvim',
    config = function()
        gitsigns.setup {
            signs = {
                add = { text = '┃' }, -- text = '+',
                change = { text = '┃' }, --text = '~',
                delete = { text = '_' }, --text = '_',
                topdelete = { text = '‾' }, -- text = '‾',
                changedelete = { text = '~' }, -- text = '~',
                untracked = { text = '┆' },
            },
            signs_staged = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
            on_attach = function()
                -- actions
                map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Git diff' })
                map('n', '<leader>gl', function()
                    gitsigns.blame_line { full = true }
                end, { desc = 'Git blame line' })
                map('n', '<leader>gh', gitsigns.toggle_current_line_blame, { desc = 'Git toggle blame line' })
            end,
        }
    end,
}
