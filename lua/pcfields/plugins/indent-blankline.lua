-- https://github.com/lukas-reineke/indent-blankline.nvim
-- Add indentation guides even on blank lines

require("indent_blankline").setup {
    -- See `:help indent_blankline.txt`
    
    char = '┊',
    show_trailing_blankline_indent = false
}
