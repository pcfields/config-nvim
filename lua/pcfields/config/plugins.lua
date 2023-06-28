-- Install package manager ----------------------------------
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
-----------------------------------------------------

local plugins = {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    --
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    'windwp/nvim-autopairs',
    --
    -- Colorschemes
    {
        'marko-cerovac/material.nvim', -- https://github.com/marko-cerovac/material.nvim
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    'navarasu/onedark.nvim', -- https://github.com/navarasu/onedark.nvim
    'sainnhe/gruvbox-material', -- https://github.com/sainnhe/gruvbox-material    
    'Mofiqul/vscode.nvim', -- https://github.com/Mofiqul/vscode.nvim
    --
    'm4xshen/autoclose.nvim', --https://github.com/m4xshen/autoclose.nvim 
    'numToStr/Comment.nvim',
    'lewis6991/gitsigns.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'nvim-lualine/lualine.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'folke/twilight.nvim',
    'folke/which-key.nvim',
    'kdheepak/lazygit.nvim',
    {
        "folke/trouble.nvim", --https://github.com/folke/trouble.nvim
        dependencies = { 
            "nvim-tree/nvim-web-devicons" 
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects'
        },
        build = ":TSUpdate",
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        },
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {-- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        }
    },
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true }, 
            { 'williamboman/mason-lspconfig.nvim' },
            { 'j-hui/fidget.nvim', version= 'legacy', opts = {} }, -- Useful status updates for LSP 
            { 'folke/neodev.nvim' } -- Additional lua configuration, makes nvim stuff amazing!
        }
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
          -- Creates a beautiful debugger UI
          'rcarriga/nvim-dap-ui',
          -- Installs the debug adapters for you
          'williamboman/mason.nvim',
          'jay-babu/mason-nvim-dap.nvim',
          -- Add your own debuggers here
          -- 'leoluz/nvim-dap-go',
        },
    }
}

local opts = {}

require("lazy").setup(plugins, opts)