-- https://github.com/nvim-telescope/telescope.nvim
-- See `:help telescope` and `:help telescope.setup()`

-- Fuzzy Finder (files, lsp, etc)

local map = require('pcfields.utils').map

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false
            }
        },
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                height = 0.9,
                preview_cutoff = 120,
                prompt_position = "bottom",
                width = 0.9
            },
        },
    }
}

local builtin = require('telescope.builtin');

-- See `:help telescope.builtin`
map('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>si', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false
        })
end, { desc = 'Fuzzily [S]earch [I]n current buffer' })

map('n', '<leader>sgf', builtin.git_files, { desc = '[S]earch [G]it [F]iles' })
map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>st', builtin.live_grep, { desc = '[S]earch by [t]ext using Grep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })



-- Fuzzy Finder Algorithm which requires local dependencies to be built.
-- Only load if `make` is available. Make sure you have the system
-- requirements installed.
--
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
