-- https://github.com/akinsho/bufferline.nvim

require('bufferline').setup {
    options = {
        mode = 'buffers',         -- set to "tabs" to only show tabpages instead
        diagnostics = 'nvim_lsp', -- false | "nvim_lsp" | "coc",
        numbers = 'ordinal',      --"none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        indicator = {
            icon = '▎',         -- this should be omitted if indicator style is not 'icon'
            style = 'icon',       --  'icon' | 'underline' | 'none',
        },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match 'error' and ' ' or ' '
            return ' ' .. icon .. count
        end,
        offsets = {
            {
                filetype = 'neo-tree',
                text = 'File Explorer',
                text_align = 'left',
                highlight = "Directory"
            },
        },
        show_buffer_icons = false, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = 'slant',
        always_show_bufferline = false
    },
}
