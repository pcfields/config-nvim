-- https://github.com/navarasu/onedark.nvim
-- https://github.com/sainnhe/gruvbox-material
-- https://github.com/marko-cerovac/material.nvim
-- https://github.com/Mofiqul/vscode.nvim

local colorscheme = 'onedark'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found')
    return
end
----------------------------------------------------------------
-- List of Themes available
----------------------------------------------------------------

-- Material theme
-- vim.g.material_style = "palenight" -- darker, lighter, oceanic, palenight,deep ocean

require('onedark').setup {
    style = 'light', -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
}
require('onedark').load()
----------------------------------------------------------------
-- require('vscode').load('dark')
----------------------------------------------------------------
-- vim.cmd 'colorscheme gruvbox-material'
----------------------------------------------------------------
