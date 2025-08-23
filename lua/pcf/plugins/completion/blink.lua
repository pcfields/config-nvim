-- https://github.com/Saghen/blink.cmp

return {
	"saghen/blink.cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
	},
	version = "*",
	config = function(_, opts)
		-- Setup LuaSnip first
		require("luasnip").setup({
			enable_autosnippets = true,
		})

		-- Load custom snippets
		require("pcf.snippets.all")

		-- Setup blink.cmp
		require("blink.cmp").setup(opts)
	end,

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = "enter",

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-y>"] = { "select_and_accept" },
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },

			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			["<C-k>"] = { "select_prev", "fallback_to_mappings" },
			["<C-j>"] = { "select_next", "fallback_to_mappings" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		-- Use a preset for snippets, check the snippets documentation for more information
		snippets = { preset = "luasnip" },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		-- Disable cmdline
		cmdline = {
			enabled = false,
		},
		completion = {
			menu = {
				-- Don't automatically show the completion menu
				-- auto_show = false,

				-- Don't show completion menu automatically when searching
				-- auto_show = function(ctx)
				-- 	return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
				-- end,
			},
			-- Don't select by default, auto insert on selection
			list = {
				selection = { preselect = false, auto_insert = true },
			},
			-- Auto brackets configuration
			accept = {
				auto_brackets = { enabled = false },
			},
			ghost_text = {
				enabled = true,
			},
		},

		-- Signature help configuration (top-level)
		signature = {
			enabled = true,
		},
	},
	opts_extend = { "sources.default" },
}
