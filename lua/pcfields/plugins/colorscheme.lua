--------------------------------------------------------------
-- THEMES
--------------------------------------------------------------
-- NOTE: Configure options before setting colorscheme.
-- No need to call setup function unless you want to overide the default


--------------------------------------------------------------
-- THEME: NightFox
-- URL: https://github.com/EdenEast/nightfox.nvim
-- options >>  nightfox | carbonfox | duskfox
--------------------------------------------------------------
require('nightfox').setup {}
local colorscheme = 'carbonfox' --
--
-- ====================================================================


local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found')
    return
end
