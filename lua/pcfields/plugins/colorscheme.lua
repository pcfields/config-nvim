return {{
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin"
}, {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'onedark'
    end
}, {"sainnhe/gruvbox-material"}}

