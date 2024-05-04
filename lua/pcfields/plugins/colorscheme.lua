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

require('onedark').setup {
    style = 'deep', -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
}

require('onedark').load()
