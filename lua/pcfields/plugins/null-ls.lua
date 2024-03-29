-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require 'null-ls'
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup {
    sources = {
        --[[ formatting ]]
        formatting.prettier,
        formatting.eslint_d,

        --[[ diagnostics ]]
        diagnostics.eslint_d,

        --[[ code actions ]]
        code_actions.eslint_d,
    },
    on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds {
                group = augroup,
                buffer = bufnr,
            }

            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format {
                        bufnr = bufnr,
                    }
                end,
            })
        end
    end,
}
