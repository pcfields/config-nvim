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
        subscript_expression = '[',
        object = '{',
        object_pattern = '{',
        object_type = '{',
        interface_declaration = '{',
        enum_declaration = '{',
        statement_block = '{',
        template_substitution = '{',
        type_parameters = '<',
        type_parameter = '<',
        type_arguments = '<',
        formal_parameters = '(',
        arguments = '(',
        argument = '(',
        for_statement = '(',
        parenthesized_expression = '(',
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

-- Function to play a macro from a specified register
function Utils.play_macro()
    -- Prompt the user for a register
    local register_letter = vim.fn.input 'Play macro from register: @'

    if register_letter ~= '' then
        vim.cmd('normal! @' .. register_letter) -- Play the macro in the specified register
    else
        print 'No register specified'
    end
end

-- Function to play a macro from a specified register
function Utils.record_macro()
    -- Prompt the user for a register
    local register_letter = vim.fn.input 'Record macro in register: @'

    if register_letter ~= '' then
        vim.cmd('normal! q' .. register_letter) -- Play the macro in the specified register
    else
        print 'No register specified'
    end
end

function Utils.macro_recording_text()
    local reg = vim.fn.reg_recording()

    if reg == '' then
        return ''
    end

    return 'Recording @' .. reg
end

return Utils
