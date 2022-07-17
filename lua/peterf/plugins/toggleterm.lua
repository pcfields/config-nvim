--[[
Description:
    A neovim plugin to persist and toggle multiple terminals during an editing session
Link:
    https://github.com/akinsho/toggleterm.nvim
--]] --
require("toggleterm").setup {
    open_mapping = [[<c-\>]],
    direction = 'float'
}
