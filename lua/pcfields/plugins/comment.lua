-- https://github.com/numToStr/Comment.nvim

-- "gc" to comment visual regions/lines
require('Comment').setup {
    padding = true, ---Add a space b/w comment and the line
    sticky = true,  ---Whether the cursor should stay at its position
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        line = '<leader>c',   ---Line-comment toggle keymap
        block = '<leader>cb', ---Block-comment toggle keymap
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        line = '<leader>c',   ---Line-comment keymap
        block = '<leader>cb', ---Block-comment keymap
    },
    ---LHS of extra mappings
    extra = {
        above = 'gcO',---Add comment on the line above
        below = 'gco',---Add comment on the line below
        eol = 'gcA',---Add comment at the end of line
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        basic = true,---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        extra = true,---Extra mapping; `gco`, `gcO`, `gcA`
    },
}

----------------------------------------------------------------
-- Default keymaps
----------------------------------------------------------------

-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

