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
            desc = 'View Buffers',
        },
        {
            '<leader>se',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Search everywhere using Grep',
        },
        {
            '<leader>sc',
            function()
                Snacks.picker.command_history()
            end,
            desc = 'Search Command History',
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
            desc = 'Recent',
        },
        -- git
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'Git Log File',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gs',
            function()
                Snacks.picker.git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>gd',
            function()
                Snacks.picker.git_diff()
            end,
            desc = 'Git Diff',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git Branches',
        },
        {
            '<leader>sw',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Visual selection or word',
            mode = { 'n', 'x' },
        },
        {
            '<leader>so',
            function()
                Snacks.picker.registers()
            end,
            desc = 'Registers',
        },
        {
            '<leader>sC',
            function()
                Snacks.picker.commands()
            end,
            desc = 'Search Commands',
        },
        {
            '<leader>sd',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = 'Search Diagnostics',
        },
        {
            '<leader>sD',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = 'Search Diagnostics',
        },
        {
            '<leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Search Help Pages',
        },
        {
            '<leader>sj',
            function()
                Snacks.picker.jumps()
            end,
            desc = 'Search Jumps',
        },
        {
            '<leader>sm',
            function()
                Snacks.picker.marks()
            end,
            desc = 'Search Marks',
        },
        {
            '<leader>uc',
            function()
                Snacks.picker.colorschemes()
            end,
            desc = 'Search Colorschemes',
        },
        {
            '<leader>vp',
            function()
                Snacks.picker.projects()
            end,
            desc = 'View Projects',
        },
        -- LSP
        {
            '<leader>od',
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = 'Goto Definition',
        },
        {
            '<leader>or',
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = 'Goto References',
        },
        {
            '<leader>oi',
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = 'Goto Implementation',
        },
        {
            '<leader>ot',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Goto T[y]pe Definition',
        },
        {
            '<leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
    },
}
