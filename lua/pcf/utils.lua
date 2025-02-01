local Utils = {}

function Utils.map(mode, lhs, rhs, opts)
    -- Initialize opts if it's not provided
    if opts == nil then
        opts = {}
    end

    -- Set default values for opts
    if opts.silent == nil then
        opts.silent = true
    end

    if opts.noremap == nil then
        opts.noremap = true
    end

    -- Create the mapping
    vim.keymap.set(mode, lhs, rhs, opts)
end

local function get_first_char_of_node(treesitter_node)
    local CURRENT_BUFFER = 0

    local start_row, start_col, _, _ = treesitter_node:range()
    local ending_row = start_row + 1
    local is_newline_included = false

    local current_node_line = vim.api.nvim_buf_get_lines(CURRENT_BUFFER, start_row, ending_row, is_newline_included)[1]
    local first_char_of_line = current_node_line:sub(start_col + 1, start_col + 1)

    return first_char_of_line
end

local function get_suffix_for_string_node(treesitter_node)
    local first_char_of_line = get_first_char_of_node(treesitter_node)

    return first_char_of_line == "'" and "'" or '"'
end

local node_type_command_suffixes = {
    array = '[',
    subscript_expression = '[',
    object = '{',
    object_pattern = '{',
    object_type = '{',
    interface_declaration = '{',
    enum_declaration = '{',
    statement_block = '{',
    template_substitution = '{',
    jsx_expression = '{',
    named_imports = '{',
    type_parameters = '<',
    type_parameter = '<',
    type_arguments = '<',
    jsx_self_closing_element = '<',
    jsx_opening_element = '<',
    formal_parameters = '(',
    arguments = '(',
    argument = '(',
    for_statement = '(',
    parenthesized_expression = '(',
    template_string = '`',
    string = get_suffix_for_string_node,
}

local function get_command_suffix(treesitter_node)
    local node_type = treesitter_node:type()
    local command_suffix = node_type_command_suffixes[node_type]

    if type(command_suffix) == 'function' then
        command_suffix = command_suffix(treesitter_node)
    end

    return command_suffix
end

local function get_treesitter_node_at_cursor()
    return require('nvim-treesitter.ts_utils').get_node_at_cursor()
end

function Utils.execute_command_on_enclosing_node(command)
    local treesitter_node = get_treesitter_node_at_cursor()

    while treesitter_node do
        local command_suffix = get_command_suffix(treesitter_node)

        if command_suffix then
            -- Execute the command with the suffix .e.g `di{` or `yi{`
            vim.cmd('normal! ' .. command .. command_suffix)
            return
        end

        treesitter_node = treesitter_node:parent()
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
