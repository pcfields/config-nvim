--[[
Description:
    A super powerful autopair plugin for Neovim that supports multiple characters.
Link:
    https://github.com/windwp/nvim-autopairs
--]] --
local status_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

nvim_autopairs.setup {}
