local conform = require 'conform'

conform.setup {
    formatters_by_ft = {
        javascript = { 'biome' },
        typescript = { 'biome' },
        javascriptreact = { 'biome' },
        typescriptreact = { 'biome' },
        css = { 'biome' },
        json = { 'biome' },
        yaml = { 'biome' },
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
