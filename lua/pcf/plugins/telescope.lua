-- https://github.com/nvim-telescope/telescope.nvim
-- See `:help telescope` and `:help telescope.setup()`

-- Fuzzy Finder (files, lsp, etc)

return { -- Search
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    version = '*',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { -- Fuzzy searching functionality
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    config = function()
        local map = require('pcf.utils').map
        local telescope_builtin = require 'telescope.builtin'
        local telescope = require 'telescope'

        telescope.setup {
            defaults = {
                -- path_display = { shorten = { len = 3 } },
                path_display = { 'truncate' },
                layout_strategy = 'vertical',
                layout_config = {
                    horizontal = {
                        height = 0.9,
                        width = 0.9,
                        preview_cutoff = 50,
                        prompt_position = 'top',
                    },
                },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
            pickers = {
                buffers = {
                    previewer = false,
                    initial_mode = 'normal',
                    theme = 'dropdown',
                    path_display = { 'tail' },
                    layout_config = {
                        prompt_position = 'top',
                    },
                },
                marks = {
                    initial_mode = 'normal',
                },
            },
        }

        -- See `:help telescope.builtin`

        local telescope_themes_dropdown = function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end

        local search_files = function()
            local ok = pcall(require('telescope.builtin').git_files, {
                show_untracked = true,
            })

            if not ok then
                require('telescope.builtin').find_files()
            end
        end

        local telescope_buffers = function()
            telescope_builtin.buffers { sort_mru = true, sort_lastused = true }
        end

        local telescope_marks = function()
            telescope_builtin.marks { sort_mru = true, sort_lastused = true }
        end

        -- Files
        map('n', '<leader>vv', telescope_buffers, { desc = 'Find existing buffers' })
        map('n', '<leader>sr', telescope_builtin.oldfiles, { desc = 'Search recently opened files' })
        map('n', '<leader>sf', search_files, { desc = 'Search Files' })
        map('n', '<leader>si', telescope_themes_dropdown, { desc = 'Fuzzily Search In current buffer' })
        -- Jumplist
        map('n', '<leader>sj', telescope_builtin.jumplist, { desc = 'Search Jump List' })
        map('n', '<leader>sm', telescope_marks, { desc = 'Search marks' })
        -- Text
        map('n', '<leader>sw', telescope_builtin.grep_string, { desc = 'Search current Word' })
        map('n', '<leader>se', telescope_builtin.live_grep, { desc = 'Search everywhere by text using Grep' })
        map('n', '<leader>sh', telescope_builtin.help_tags, { desc = 'Search Help' })
        -- Diagnostics
        map('n', '<leader>sd', telescope_builtin.diagnostics, { desc = 'Search Diagnostics' })
        -- Git
        map('n', '<leader>sg', telescope_builtin.git_files, { desc = 'Searh Git Files' })
        map('n', '<leader>gs', telescope_builtin.git_status, { desc = 'Search Git Satus' })
        map('n', '<leader>gb', telescope_builtin.git_branches, { desc = 'Search Git Branches' })

        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        --
        -- Enable telescope fzf native, if installed
        pcall(telescope.load_extension, 'fzf')
    end,
}
