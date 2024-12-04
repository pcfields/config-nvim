-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { timeout = 300 }
    end,
    group = highlight_group,
    pattern = '*',
})

-- Astro commands
vim.cmd 'autocmd BufRead,BufEnter *.astro set filetype=astro'

vim.filetype.add {
    extension = {
        astro = 'astro',
    },
}
-- Taken from https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/options.lua
--  Create colors to use in winbar
vim.cmd(string.format([[highlight FilePathColor guifg=%s]], '#78a9ff'))
vim.cmd(string.format([[highlight BuffersCountColor guifg=%s]], '#00ff00'))

-- Function to get the full path and replace the home directory with ~
local function get_formatted_file_path()
    local full_path = vim.fn.expand '%:p'

    return full_path:gsub(vim.fn.expand '$HOME', '~')
end

-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
    local open_buffers = vim.fn.execute 'ls'
    local count = 0

    -- Match only lines that represent buffers, typically starting with a number followed by a space
    for line in string.gmatch(open_buffers, '[^\r\n]+') do
        if string.match(line, '^%s*%d+') then
            count = count + 1
        end
    end

    return count
end

local function update_winbar()
    local formatted_file_path = get_formatted_file_path()
    local open_buffers_count = get_buffer_count()
    local is_buffer_modified = vim.api.nvim_get_option_value('modified', { buf = 0 })

    local modified_buffer_icon = is_buffer_modified and ' 🟠 ' or ' ⚫️ '

    vim.opt.winbar = table.concat {
        modified_buffer_icon,
        '%#BuffersCountColor#(' .. open_buffers_count .. ') ',
        '%#FilePathColor#',
        '' .. formatted_file_path,
    }
end

-- Autocmd to update the winbar on events
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' }, {
    callback = update_winbar,
})
