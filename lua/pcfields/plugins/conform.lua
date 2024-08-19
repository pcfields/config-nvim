local conform = require 'conform'

conform.setup {
    formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        html = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        liquid = { 'prettier' },
        lua = { 'stylua' },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    },
}

vim.keymap.set({ 'n', 'v' }, '<leader>ff', function()
    conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    }
end, { desc = 'Format file or range (in visual mode)' })
