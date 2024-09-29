-- https://github.com/akinsho/bufferline.nvim

require('bufferline').setup {
    options = {
        mode = 'tabs', --"buffers"| "tabs" -- set to "tabs" to only show tabpages instead
        diagnostics = 'nvim_lsp', -- false | "nvim_lsp" | "coc",
        numbers = 'ordinal', --"none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match 'error' and ' ' or ' '
            return ' ' .. icon .. count
        end,
        offsets = {
            --[[ {
                filetype = 'neo-tree',
                text = 'File Explorer',
                text_align = 'left',
                highlight = "Directory",
                separator = true -- use a "true" to enable the default, or set your own character
            }, ]]
        },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = 'thick', -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
        always_show_bufferline = true,
    },
}
