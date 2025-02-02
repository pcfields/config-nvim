-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim

return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} }, -- Useful status updates for LSP
		{ "saghen/blink.cmp" },
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		local function buffer_format()
			vim.lsp.buf.format()
		end

		--  This function gets run when an LSP connects to a particular buffer.
		local on_attach = function(_, bufnr)
			vim.api.nvim_buf_create_user_command(bufnr, "Format", buffer_format, { desc = "Format current buffer with LSP" })
		end

		--  Add any additional override configuration in the following tables. They will be passed to
		--  the `settings` field of the server config. You must look up that documentation yourself.
		local language_servers = {
			marksman = {},
			jsonls = {},
			cssls = {},
			ts_ls = {},
			eslint = {},
			emmet_ls = {},
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

		-- code completion supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		mason.setup()

		-- Ensure the language_servers are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(language_servers),
			automatic_installation = true,
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = language_servers[server_name],
				})
			end,
		})
	end,
}
