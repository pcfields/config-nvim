local Utils = {}

function Utils.map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

function Utils.perform_action_on_node(command)
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()

    local node_type_commands = {
        array = '[',
        object = '{',
        object_pattern = '{',
        formal_parameters = '(',
        string = '"',
        string_fragment = '"',
    }

    while node do
        local node_type = node:type()
        local command_suffix = node_type_commands[node_type]

        if command_suffix then
            vim.cmd('normal! ' .. command .. command_suffix)

            return
        end

        node = node:parent()
    end
end

return Utils
