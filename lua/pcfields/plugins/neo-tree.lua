-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

require('neo-tree').setup {
    window = {
        position = 'top', -- left, right, top, bottom, float, current
    },
    filesystem = {
        follow_current_file = {
            enabled = true,         -- This will find and focus the file in the active buffer every time
            -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
    },
}
