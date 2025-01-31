-- https://github.com/numToStr/Comment.nvim



return {
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
        local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'

        require('Comment').setup {
            -- for commenting tsx, jsx, svelte, html files
            pre_hook = ts_context_commentstring.create_pre_hook(),
            padding = true, ---Add a space b/w comment and the line
            sticky = true,  ---Whether the cursor should stay at its position
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                line = '<leader>cl',  ---Line-comment toggle keymap
                block = '<leader>cb', ---Block-comment toggle keymap
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line = '<leader>cl',  ---Line-comment keymap
                block = '<leader>cb', ---Block-comment keymap
            },
            mappings = {
                basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
            },
        }
    end,
}
