--[[
Description:
    Super fast git decorations implemented purely in lua/teal.
Link:
    https://github.com/lewis6991/gitsigns.nvim
--]] --
--
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gitsigns.setup()
