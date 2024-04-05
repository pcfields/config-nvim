-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/hrsh7th/cmp-nvim-lsp

local mason_lspconfig = require 'mason-lspconfig'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local lspconfig = require 'lspconfig'
local telescope_builtin = require 'telescope.builtin'

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
-- https://github.com/folke/neodev.nvim
-- Automatically configures lua-language-server for your Neovim config, Neovim runtime and plugin directories
require('neodev').setup {}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, {
            buffer = bufnr,
            desc = desc,
        })
    end

    nmap('gd', telescope_builtin.lsp_definitions, 'Go to Definition')
    nmap('gr', telescope_builtin.lsp_references, 'Go to References')
    nmap('gi', vim.lsp.buf.implementation, 'Go to Implementation')
    nmap('<leader>dtd', vim.lsp.buf.type_definition, 'Display Type Definition')
    nmap('<leader>dv', telescope_builtin.lsp_document_symbols, 'Display Document Variables/Symbols')
    nmap('<leader>dws', telescope_builtin.lsp_dynamic_workspace_symbols, 'Display Workspace Symbols')
    nmap('<leader>dd', vim.lsp.buf.hover, 'Display Hover Documentation')
    nmap('<leader>ds', vim.lsp.buf.signature_help, 'Display Signature Documentation')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {
        desc = 'Format current buffer with LSP',
    })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    remark_ls = {},
    jsonls = {},
    cssmodules_ls = {},
    cssls = {},
    rust_analyzer = {},
    tsserver = {},
    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Ensure the servers above are installed
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
}

mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}
