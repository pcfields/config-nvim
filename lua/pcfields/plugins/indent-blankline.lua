-- https://github.com/lukas-reineke/indent-blankline.nvim
-- Add indentation guides even on blank lines
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#222222 gui=nocombine]]

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = false,
    show_current_context_start = true,
    char_highlight_list = {"IndentBlanklineIndent1"}
}