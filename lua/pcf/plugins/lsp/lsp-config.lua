return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim",          config = true },
    { "williamboman/mason-lspconfig.nvim" },
    { "saghen/blink.cmp" },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Initialize capabilities first
    local capabilities = require("blink.cmp").get_lsp_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_create_user_command(
        bufnr,
        "Format",
        function()
          vim.lsp.buf.format()
        end,
        { desc = "Format current buffer with LSP" })
    end

    -- Server configurations using new API
    local language_servers = {
      marksman = {},
      jsonls = {},
      cssls = {},
      ts_ls = {},
      eslint = {},
      emmet_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = { 'vim' }
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true)
            },
            telemetry = { enable = false }
          }
        },
      }
    }

    -- Configure each server using native API
    for server, config in pairs(language_servers) do
      vim.lsp.config(server, vim.tbl_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach
      }, config))
    end

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(language_servers),
    })
  end
}
