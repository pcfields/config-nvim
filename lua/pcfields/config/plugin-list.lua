local function tabnine_build_path()
    if vim.loop.os_uname().sysname == 'Windows_NT' then
        return 'pwsh.exe -file .\\dl_binaries.ps1'
    else
        return './dl_binaries.sh'
    end
end

local function load_config(package)
    return function()
        require('pcfields/' .. package)
    end
end

local plugins = {
    --------------------------------------------------------------------------------------------------------
    -- Colorschemes
    ----------------------------------------------------------------------------------------
    {
        'EdenEast/nightfox.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = load_config 'plugins.colorscheme',
    },
    --------------------------------------------------------------------------------------------------------
    -- Git related plugins
    ----------------------------------------------------------------------------------------
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'kdheepak/lazygit.nvim',
    {
        'lewis6991/gitsigns.nvim',
        config = load_config 'plugins.gitsigns',
    },
    --------------------------------------------------------------------------------------------------------
    -- Code related
    ----------------------------------------------------------------------------------------
    'tpope/vim-sleuth', -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
    { -- Autopairs
        'windwp/nvim-autopairs',
        config = load_config 'plugins.autopairs',
        event = 'InsertEnter',
    },
    { -- Commenting
        'numToStr/Comment.nvim',
        config = load_config 'plugins.comment',
        lazy = false,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
    },
    { -- dims inactive portions of the code you're editing.
        'folke/twilight.nvim',
        config = load_config 'plugins.twilight',
        event = 'VeryLazy',
        lazy = true,
    },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        config = load_config 'plugins.treesitter',
        event = 'BufRead',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'mfussenegger/nvim-ts-hint-textobject',
            'windwp/nvim-ts-autotag',
        },
        build = ':TSUpdate',
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        config = load_config 'plugins.cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip', -- source for autocompletion
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-buffer', -- source for text in buffer
            'hrsh7th/cmp-path', -- source for file system paths
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            -- 'rafamadriz/friendly-snippets', -- useful snippets
        },
    },
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        config = load_config 'plugins.lsp-config',
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
            }, -- Useful status updates for LSP
            { 'folke/neodev.nvim' }, -- Additional lua configuration, makes nvim stuff amazing!
        },
    },
    { -- Tabnine AI assistant
        'codota/tabnine-nvim',
        config = load_config 'plugins.tabnine',
        event = 'VeryLazy',
        build = tabnine_build_path(),
    },
    { -- Code formatting
        'stevearc/conform.nvim',
        config = load_config 'plugins.conform',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    { -- Code linting
        'mfussenegger/nvim-lint',
        config = load_config 'plugins.lint',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    { -- Add colors to TODO comment
        'folke/todo-comments.nvim',
        config = load_config 'plugins.todo-comments',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    { -- Run tests
        'nvim-neotest/neotest',
        config = load_config 'plugins.neo-test',
        event = 'VeryLazy',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'marilari88/neotest-vitest',
            'nvim-neotest/neotest-jest',
        },
    },
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup {}
        end,
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
    },
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup {}
        end,
    },
    --------------------------------------------------------------------------------------------------------
    -- UI related
    ----------------------------------------------------------------------------------------
    { -- Neovim statusline plugin
        'nvim-lualine/lualine.nvim',
        config = load_config 'plugins.lualine',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { -- Display keybinding information
        'folke/which-key.nvim',
        config = load_config 'plugins.which-key',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    { -- Diagnostics
        'folke/trouble.nvim',
        config = load_config 'plugins.trouble',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { -- Search
        'nvim-telescope/telescope.nvim',
        config = load_config 'plugins.telescope',
        tag = '0.1.6',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    { -- Fuzzy searching functionality
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    { -- File explorer
        'nvim-neo-tree/neo-tree.nvim',
        config = load_config 'plugins.neo-tree',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },
    -- { -- Buffer tabs
    --     'akinsho/bufferline.nvim',
    --     config = load_config 'plugins.bufferline',
    --     event = 'VeryLazy',
    --     version = '*',
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- },
    { -- Improved vim editing window
        'stevearc/dressing.nvim',
        config = load_config 'plugins.dressing',
    },
    { -- Improved code folding
        'kevinhwang91/nvim-ufo',
        config = load_config 'plugins.ufo',
        dependencies = { 'kevinhwang91/promise-async' },
    },
    { -- Pretty notification messages
        'folke/noice.nvim',
        config = load_config 'plugins.noice',
        event = 'VeryLazy',
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
        },
    },
    { -- Terminal
        'akinsho/toggleterm.nvim',
        config = load_config 'plugins.toggleterm',
        version = '*',
    },
    { -- Debugger
        'mfussenegger/nvim-dap',
        dependencies = { -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui', -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim', -- Add your own debuggers here
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',
            'williamboman/mason.nvim',
            'mxsdev/nvim-dap-vscode-js',
        },
        config = load_config 'plugins.dap',
    },
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('refactoring').setup()
        end,
    },
    --------------------------------------------------------------------------------------------------------
    -- Misc or Universal Plugins
    ----------------------------------------------------------------------------------------
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'nvim-tree/nvim-web-devicons',
    },
}

return {
    plugins = plugins,
}
