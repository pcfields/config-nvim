-- https://github.com/nvim-neo-tree/neo-tree.nvim

require('neo-tree').setup {
    reveal = true,
    window = {
        position = 'float', -- left, right, top, bottom, float, current
    },
    filesystem = {
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
    },
}
