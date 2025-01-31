-- https://github.com/folke/snacks.nvim
--
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        animate = { enabled = true },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        dim = { enabled = true },
        indent = { enabled = true },
        lazygit = { enabled = true },
        input = { enabled = true },
        notify = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true },
        words = { enabled = true },
        picker = {},
    },
    keys = {
        {
            '<leader>vv',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'View Open Buffers',
        },
        -- Search
        {
            '<leader>se',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Search everywhere using Grep',
        },
        {
            '<leader>sf',
            function()
                Snacks.picker.files()
            end,
            desc = 'Search Files',
        },
        {
            '<leader>sg',
            function()
                Snacks.picker.git_files()
            end,
            desc = 'Search Git Files',
        },
        {
            '<leader>sr',
            function()
                Snacks.picker.recent()
            end,
            desc = 'Search Recent Files',
        },
        {
            '<leader>sw',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Search selection or word',
            mode = { 'n', 'x' },
        },
        -- git
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'Git File Log',
        },
        {
            '<leader>gh',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'Git Log History',
        },
        {
            '<leader>gs',
            function()
                Snacks.picker.git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>gdl',
            function()
                Snacks.picker.git_diff()
            end,
            desc = 'Git Diff list',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'List Git Branches',
        },
        {
            '<leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Search Help Pages',
        },
        -- LSP
        {
            '<leader>jd',
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = 'Goto Definition',
        },
        {
            '<leader>ji',
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = 'Goto Implementation',
        },
        -- Lists
        {
            '<leader>ef',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = 'Search Diagnostics',
        },
        {
            '<leader>ea',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Search All Diagnostics',
        },
        -- Open
        {
            '<leader>or',
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = 'Goto References',
        },
        {
            '<leader>os',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'List LSP Symbols',
        },
        {
            '<leader>ot',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Goto T[y]pe Definition',
        },
        {
            '<leader>om',
            function()
                Snacks.picker.marks()
            end,
            desc = 'Search Marks',
        },
        {
            '<leader>oj',
            function()
                Snacks.picker.jumps()
            end,
            desc = 'Search Jumps',
        },
        {
            '<leader>oo',
            function()
                Snacks.picker.registers()
            end,
            desc = 'Display Registers',
        },
    },
}
