local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path}
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install your plugins here
return packer.startup(function(use)

    -- Colorschemes
    use 'sainnhe/gruvbox-material'

    -- Plugins
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    } -- styled tabs
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    use 'lewis6991/gitsigns.nvim' -- git decorations/signs for added, removed, and changed lines 
    use 'kyazdani42/nvim-web-devicons' --  development file icons
    use 'kyazdani42/nvim-tree.lua' -- NVIM Tree file explorer 
    use 'dstein64/nvim-scrollview' -- displays interactive vertical scrollbars
    use 'nvim-lualine/lualine.nvim' -- status line at bottom of screen
    use 'folke/trouble.nvim'
    use 'vuki656/package-info.nvim'
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "b0o/schemastore.nvim" -- Access to the SchemaStore catalog

    -- Comments
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use 'numToStr/Comment.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    } -- The main Telescope plugin  

    -- Treesitter & related plugins
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'folke/twilight.nvim'
    use 'windwp/nvim-ts-autotag'

    -- LSP 
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use "williamboman/nvim-lsp-installer" -- plugin that allows you to manage LSP servers
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'jose-elias-alvarez/null-ls.nvim' -- LSP diagnostics, code actions, and formatting

    -- cmp/Autocompletion plugins
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions

    -- Snippets
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp

    -- Testing
    use 'vim-test/vim-test'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
