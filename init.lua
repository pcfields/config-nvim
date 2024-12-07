-- Load configuration
require 'pcf.config.options'
require 'pcf.config.keymaps'
require 'pcf.config.auto-commands'

-- Install plugin manager
local plugin_manager = require 'pcf.config.plugin-manager'

-----------------------------------------------------

local opts = {}

-- Load plugins
plugin_manager.setup({
    require 'pcf.plugins.themes.nightfox',
    require 'pcf.plugins.autopairs',
    require 'pcf.plugins.cmp',
    require 'pcf.plugins.comment',
    require 'pcf.plugins.conform',
    require 'pcf.plugins.dap',
    require 'pcf.plugins.dressing',
    require 'pcf.plugins.gitsigns',
    require 'pcf.plugins.lazydev',
    require 'pcf.plugins.lint',
    require 'pcf.plugins.lsp-config',
    require 'pcf.plugins.lualine',
    require 'pcf.plugins.neo-test',
    require 'pcf.plugins.neo-tree',
    require 'pcf.plugins.noice',
    require 'pcf.plugins.nvim-surround',
    require 'pcf.plugins.refactoring',
    require 'pcf.plugins.tabnine',
    require 'pcf.plugins.telescope',
    require 'pcf.plugins.todo-comments',
    require 'pcf.plugins.treesitter',
    require 'pcf.plugins.trouble',
    require 'pcf.plugins.twilight',
    require 'pcf.plugins.ufo',
    require 'pcf.plugins.which-key',
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'kdheepak/lazygit.nvim' },
    { 'sindrets/diffview.nvim' },
    { 'tpope/vim-sleuth' }, -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
}, opts)
