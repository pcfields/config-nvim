-- https://github.com/nvim-lualine/lualine.nvim
-- See `:help lualine.txt`

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'onedark',
        -- theme = 'vscode',
        -- theme = 'material-nvim',
        component_separators = '|',
        section_separators = ''
    }
}
