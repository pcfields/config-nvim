--------------------------------------------------------------
-- THEMES
--------------------------------------------------------------
-- NOTE: Configure options before setting colorscheme.
-- No need to call setup function unless you want to overide the default

--------------------------------------------------------------
-- THEME: Rose Pine
-- URL: https://github.com/rose-pine/neovim
-- options >>  rose-pine-main | rose-pine-moon
--------------------------------------------------------------

require('rose-pine').setup {
    styles = {
        bold = true,
        italic = false,
        transparency = false,
    },
}
local colorscheme = 'rose-pine-moon'
-- ====================================================================

--------------------------------------------------------------
-- THEME: NightFox
-- URL: https://github.com/EdenEast/nightfox.nvim
-- options >>  nightfox | carbonfox | duskfox
--------------------------------------------------------------
-- require('nightfox').setup {}
-- local colorscheme = 'nightfox'
-- ====================================================================

--------------------------------------------------------------
-- THEME: Kanagawa
-- URL: https://github.com/rebelot/kanagawa.nvim
-- options >>  kanagawa-dragon
--------------------------------------------------------------
-- require('kanagawa').setup {}
-- local colorscheme = 'kanagawa-dragon'
-- ====================================================================

--------------------------------------------------------------
-- THEME: Catppuccin
-- URL: https://github.com/catppuccin/nvim
-- options >>  'catppuccin-macchiato' | 'catppuccin-mocha'
--------------------------------------------------------------
-- require('catppuccin').setup {}
-- local colorscheme = 'catppuccin-mocha'
-- ====================================================================

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found')
    return
end
