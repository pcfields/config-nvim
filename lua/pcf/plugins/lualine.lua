-- https://github.com/nvim-lualine/lualine.nvim
-- See `:help lualine.txt`

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto', -- auto | palenight | base16 16color ayu_dark  ayu_mirage codedark
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diagnostics', 'filename', 'filesize' },
        lualine_c = { 'branch', 'diff' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}
