return { -- tokyonight
{
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
        style = "moon"
    }
}, -- catppuccin
{
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin"
}, { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'onedark'
    end
}}

