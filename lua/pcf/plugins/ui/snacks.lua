-- https://github.com/folke/snacks.nvim
--

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local u = require("pcf.plugins.ui.snacks-utils")
		local map = require("pcf.utils").map
		local snacks = require("snacks")

		snacks.setup({
			animate = { enabled = true },
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			dim = { enabled = true },
			indent = { enabled = true },
			lazygit = { enabled = true },
			input = { enabled = true },
			notify = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			words = { enabled = true },
			picker = {},
			scope = { enabled = true },
		})

		map({ "n", "v" }, "<leader>vv", u.ViewOpenBuffers, { desc = "View Open Buffers" })
		-- Search
		map({ "n", "v" }, "<leader>se", u.SearchGrep, { desc = "Search everywhere using Grep" })
		map({ "n", "v" }, "<leader>sf", u.SearchFiles, { desc = "Search Files" })
		map({ "n", "v" }, "<leader>sg", u.SearchGitFiles, { desc = "Search Git Files" })
		map({ "n", "v" }, "<leader>sr", u.SearchRecentFiles, { desc = "Search Recent Files" })
		map({ "n", "v" }, "<leader>sw", u.SearchGrepWord, { desc = "Search selection or word" })
		-- git)
		map({ "n", "v" }, "<leader>gl", u.GitFileLog, { desc = "Git File Log" })
		map({ "n", "v" }, "<leader>gg", u.OpenLazyGit, { desc = "LazyGit" })
		map({ "n", "v" }, "<leader>gh", u.GitLogHistory, { desc = "Git Log History" })
		map({ "n", "v" }, "<leader>gs", u.GitStatus, { desc = "Git Status" })
		map({ "n", "v" }, "<leader>gdl", u.GitDiffList, { desc = "Git Diff list" })
		map({ "n", "v" }, "<leader>gb", u.ListGitBranches, { desc = "List Git Branches" })
		map({ "n", "v" }, "<leader>sh", u.SearchHelpPages, { desc = "Search Help Pages" })
		-- LSP)
		map({ "n", "v" }, "<leader>jd", u.GotoDefinition, { desc = "Goto Definition" })
		map({ "n", "v" }, "<leader>ji", u.GotoImplementation, { desc = "Goto Implementation" })
		-- Lists)
		map({ "n", "v" }, "<leader>ef", u.SearchDiagnosticsBuffer, { desc = "Search Diagnostics" })
		map({ "n", "v" }, "<leader>ea", u.SearchAllDiagnostics, { desc = "Search All Diagnostics" })
		-- Open)
		map({ "n", "v" }, "<leader>or", u.GotoReferences, { desc = "Goto References", nowait = true })
		map({ "n", "v" }, "<leader>os", u.ListLSPSymbols, { desc = "List LSP Symbols" })
		map({ "n", "v" }, "<leader>ot", u.GotoTypeDefinition, { desc = "Goto T[y]pe Definition" })
		map({ "n", "v" }, "<leader>om", u.SearchMarks, { desc = "Search Marks" })
		map({ "n", "v" }, "<leader>oj", u.SearchJumps, { desc = "Search Jumps" })
		map({ "n", "v" }, "<leader>oo", u.DisplayRegisters, { desc = "Display Registers" })
		map({ "n", "v" }, "<leader>oe", u.Explorer, { desc = "Explorer" })
		map({ "n", "v" }, "<leader>oh", vim.lsp.buf.hover, { desc = "Hover Documentation" })
		-- map({ 'n', 'v' }, '<leader>ot', u.ToggleTerminal, { desc = 'Toggle Terminal' })
		-- map({ 'n', 'v' }, '<leader>oa', u.TodoComments, { desc = 'Toggle Terminal' })
	end,
}
