-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/hrsh7th/cmp-nvim-lsp

return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason.nvim',
            config = true,
        },
        { 'williamboman/mason-lspconfig.nvim' },
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {},
        }, -- Useful status updates for LSP
    },
    config = function()
        local mason_lspconfig = require 'mason-lspconfig'
        local cmp_nvim_lsp = require 'cmp_nvim_lsp'
        local lspconfig = require 'lspconfig'
        local telescope_builtin = require 'telescope.builtin'

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

            local function open_lsp_references()
                telescope_builtin.lsp_references {
                    show_line = false,
                    include_declaration = true,
                    include_current_line = false,
                    trim_text = true,
                    reuse_win = false,
                }
            end

            nmap('<leader>od', telescope_builtin.lsp_definitions, 'Go to Definition')
            nmap('<leader>or', open_lsp_references, 'Go to References')
            nmap('<leader>oi', vim.lsp.buf.implementation, 'Go to Implementation')
            nmap('<leader>ot', vim.lsp.buf.type_definition, 'Go to Type Definition')
            nmap('<leader>oh', vim.lsp.buf.hover, 'Display Hover Documentation')
            nmap('<leader>ox', vim.lsp.buf.signature_help, 'Display Signature Documentation')
            nmap('<leader>ov', telescope_builtin.lsp_document_symbols, 'List of Document Variables/Symbols')
            -- nmap('<leader>lw', telescope_builtin.lsp_dynamic_workspace_symbols, 'Display Workspace Symbols')

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
            ts_ls = {},
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
    end,
}
