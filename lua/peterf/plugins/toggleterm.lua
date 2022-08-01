--[[
Description:
    A neovim plugin to persist and toggle multiple terminals during an editing session
Link:
    https://github.com/akinsho/toggleterm.nvim
--]] --
local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup {
    open_mapping = [[<c-\>]],
    direction = 'float'
}
