local Utils = {}

function Utils.map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false

    vim.keymap.set(mode, lhs, rhs, opts)
end

function Utils.perform_action_on_node(command)
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node_at_cursor = ts_utils.get_node_at_cursor()
    local node = node_at_cursor

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
        template_string = '`',
        string = function(current_node)
            local start_row, start_col, _, _ = current_node:range()
            local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
            local quote = line:sub(start_col + 1, start_col + 1)

            return quote == "'" and "'" or '"'
        end,
    }

    while node do
        local node_type = node:type()
        local command_suffix = node_type_commands[node_type]

        if command_suffix then
            if type(command_suffix) == 'function' then
                command_suffix = command_suffix(node)
            end

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

-- Function to get the number of open buffers using the :ls command
function Utils.get_buffer_count()
    local open_buffers = vim.fn.execute 'ls' -- ls is equal to buffers
    local count = 0

    -- Match only lines that represent buffers, typically starting with a number followed by a space
    for line in string.gmatch(open_buffers, '[^\r\n]+') do
        if string.match(line, '^%s*%d+') then
            count = count + 1
        end
    end

    return count
end

local Icons = {
    MODIFIED = ' 🟠 ',
    UNMODIFIED = ' ⚫️ ',
}

local Colors = {
    bright_green = '#00ff00',
    pale_blue = '#78a9ff',
}

function Utils.get_winbar_filename()
    vim.api.nvim_set_hl(0, 'FilePathColor', { fg = Colors.pale_blue })
    vim.api.nvim_set_hl(0, 'BuffersCountColor', { fg = Colors.bright_green, bold = true })

    local file_path = vim.api.nvim_eval_statusline('%f', {}).str
    local open_buffers_count = Utils.get_buffer_count()
    local is_buffer_modified = vim.api.nvim_eval_statusline('%m', {}).str == '[+]'
    local modified_buffer_icon = is_buffer_modified and Icons.MODIFIED or Icons.UNMODIFIED

    return '%#BuffersCountColor#' .. modified_buffer_icon .. '(' .. open_buffers_count .. ') ' .. '%#FilePathColor#' .. '' .. file_path
end

return Utils
