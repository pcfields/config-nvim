local function tabnine_build_path()
    if vim.loop.os_uname().sysname == 'Windows_NT' then
        return 'pwsh.exe -file .\\dl_binaries.ps1'
    else
        return './dl_binaries.sh'
    end
end

local function load_config(package)
    return function()
        require('pcfields/plugins.' .. package)
    end
end

local plugins = {
    -- Colorschemes ----------------------------------------------------------------------------------------
    {
        'navarasu/onedark.nvim', -- https://github.com/navarasu/onedark.nvim
        lazy = false,            -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,         -- make sure to load this before all the other start plugins
    },
    {
        'Mofiqul/vscode.nvim', -- https://github.com/Mofiqul/vscode.nvim
    },
    {
        'marko-cerovac/material.nvim', -- https://github.com/marko-cerovac/material.nvim
    },
    --------------------------------------------------------------------------------------------------------
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',
    'kdheepak/lazygit.nvim',
    -------------------------------------------------------------------------------------------------------
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    'windwp/nvim-autopairs',
    -------------------------------------------------------------------------------------------------------
    'm4xshen/autoclose.nvim', -- https://github.com/m4xshen/autoclose.nvim
    'numToStr/Comment.nvim',  -- https://github.com/numToStr/Comment.nvim
    'lukas-reineke/indent-blankline.nvim',
    'nvim-lualine/lualine.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'folke/twilight.nvim',
    'folke/which-key.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    {
        'folke/trouble.nvim', -- https://github.com/folke/trouble.nvim
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    { -- Terminal
        'akinsho/toggleterm.nvim',
        version = '*',
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        build = ':TSUpdate',
    },
    { -- File explore
        'nvim-neo-tree/neo-tree.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
    },
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip', -- source for autocompletion
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-buffer',       -- source for text in buffer
            'hrsh7th/cmp-path',         -- source for file system paths
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'rafamadriz/friendly-snippets', -- useful snippets
        },
    },
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = true,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {},
            },                       -- Useful status updates for LSP
            { 'folke/neodev.nvim' }, -- Additional lua configuration, makes nvim stuff amazing!
        },
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {                    -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui',         -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim', -- Add your own debuggers here
            -- 'leoluz/nvim-dap-go',
        },
    },
    {
        'codota/tabnine-nvim',
        build = tabnine_build_path(),
    },
    { 'David-Kunz/jester' }, -- https://github.com/David-Kunz/jester
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        config = load_config('noice'),
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
}

return {
    plugins = plugins,
}
