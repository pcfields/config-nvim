--[[
Description: 
    Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
Link: 
    https://github.com/jose-elias-alvarez/null-ls.nvim
--]] -- 
--
local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting;
local diagnostics = null_ls.builtins.diagnostics;
local completion = null_ls.builtins.completion

local sources = {formatting.stylua, formatting.prettier_d_slim, diagnostics.eslint_d, formatting.eslint_d}

null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end
            })
        end
    end
})
