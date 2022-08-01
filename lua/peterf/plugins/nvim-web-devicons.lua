--[[
Description:
    This plugin provides the icons from patched nerd font.
Link:
    https://github.com/kyazdani42/nvim-web-devicons
--]] --
--
local status_ok, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if not status_ok then
    return
end

nvim_web_devicons.setup {}
