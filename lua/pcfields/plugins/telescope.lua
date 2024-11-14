-- https://github.com/nvim-telescope/telescope.nvim
-- See `:help telescope` and `:help telescope.setup()`

-- Fuzzy Finder (files, lsp, etc)

local map = require('pcfields.utils').map
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
        -- preview = false,
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
    if vim.fn.filereadable './.git/HEAD' then
        telescope_builtin.git_files { use_git_root = false, show_untracked = true }
    else
        telescope_builtin.search_files()
    end
end

local telescope_buffers = function()
    telescope_builtin.buffers { sort_mru = true, sort_lastused = true }
end

-- Files
map('n', '<leader>bb', telescope_buffers, { desc = 'Find existing buffers' })
map('n', '<leader>sr', telescope_builtin.oldfiles, { desc = 'Search recently opened files' })
map('n', '<leader>sf', search_files, { desc = 'Search Files' })
map('n', '<leader>si', telescope_themes_dropdown, { desc = 'Fuzzily Search In current buffer' })
-- Jumplist
map('n', '<leader>sj', telescope_builtin.jumplist, { desc = 'Search Jump List' })
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
