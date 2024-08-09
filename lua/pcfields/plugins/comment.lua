-- https://github.com/numToStr/Comment.nvim

local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'

require('Comment').setup {
    -- for commenting tsx, jsx, svelte, html files
    pre_hook = ts_context_commentstring.create_pre_hook(),
    padding = true, ---Add a space b/w comment and the line
    sticky = true,  ---Whether the cursor should stay at its position
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        line = '<leader>kk',  ---Line-comment toggle keymap
        block = '<leader>kb', ---Block-comment toggle keymap
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        line = '<leader>kk',  ---Line-comment keymap
        block = '<leader>kb', ---Block-comment keymap
    },
    ---LHS of extra mappings
    -- extra = {
    --     above = '<leader>kkO', ---Add comment on the line above
    --     below = '<leader>kko', ---Add comment on the line below
    --     eol = '<leader>kkA', ---Add comment at the end of line
    -- },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
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
