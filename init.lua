-----------------------------------------------------
-- Load configuration
-----------------------------------------------------
require("pcf.config.options")
require("pcf.config.keymaps")
require("pcf.config.auto-commands")
require("pcf.config.diagnostics")

-----------------------------------------------------
-- Install plugin manager
-----------------------------------------------------
local plugin_manager = require("pcf.config.plugin-manager")

-----------------------------------------------------
-- Load plugins
-----------------------------------------------------
plugin_manager.setup({
	require("pcf.plugins.themes.nightfox"), -- MAIN THEME

	require("pcf.plugins.ai.copilot"),
	require("pcf.plugins.ai.copilot-chat"),

	require("pcf.plugins.completion.blink"),

	require("pcf.plugins.debugging.dap"),

	require("pcf.plugins.editor.autopairs"),
	require("pcf.plugins.editor.code-indentation"),
	require("pcf.plugins.editor.comment"),
	require("pcf.plugins.editor.flash"),
	require("pcf.plugins.editor.local-highlight"),
	require("pcf.plugins.editor.nvim-surround"),
	require("pcf.plugins.editor.refactoring"),
	require("pcf.plugins.editor.todo-comments"),
	require("pcf.plugins.editor.treesitter"),
	require("pcf.plugins.editor.trouble"),
	require("pcf.plugins.editor.ufo"),

	require("pcf.plugins.git.diffview"),
	require("pcf.plugins.git.gitsigns"),

	require("pcf.plugins.lsp.format"),
	require("pcf.plugins.lsp.lint"),
	require("pcf.plugins.lsp.lsp-config"),

	require("pcf.plugins.navigation.mini-files"),
	require("pcf.plugins.navigation.neo-tree"),
	require("pcf.plugins.navigation.oil"),

	require("pcf.plugins.testing.neo-test"),

	require("pcf.plugins.ui.dressing"),
	require("pcf.plugins.ui.lualine"),
	require("pcf.plugins.ui.noice"),
	require("pcf.plugins.ui.snacks"),
	require("pcf.plugins.ui.which-key"),

	require("pcf.plugins.utils.lazydev"),
}, {})
