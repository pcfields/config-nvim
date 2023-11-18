-- https://github.com/nvim-telescope/telescope.nvim
-- See `:help telescope` and `:help telescope.setup()`

-- Fuzzy Finder (files, lsp, etc)

local map = require("pcfields.utils").map

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				height = 0.9,
				preview_cutoff = 120,
				prompt_position = "bottom",
				width = 0.9,
			},
		},
	},
})

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")

local telescope_themes_dropdown = function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end

-- Files
map("n", "<leader><space>", builtin.buffers, { desc = "Find existing buffers" })
map("n", "<leader>sr", builtin.oldfiles, { desc = "Search recently opened files" })
map("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
map("n", "<leader>si", telescope_themes_dropdown, { desc = "Fuzzily Search In current buffer" })
-- Jumplist
map("n", "<leader>sjl", builtin.jumplist, { desc = "Search Jump List" })
-- Text
map("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
map("n", "<leader>se", builtin.live_grep, { desc = "Search everywhere by text using Grep" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
-- Diagnostics
map("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
-- Git
map("n", "<leader>sgf", builtin.git_files, { desc = "Searh Git Files" })
map("n", "<leader>sgs", builtin.git_status, { desc = "Search Git Satus" })
map("n", "<leader>sgb", builtin.git_branches, { desc = "Search Git Branches" })

-- Fuzzy Finder Algorithm which requires local dependencies to be built.
-- Only load if `make` is available. Make sure you have the system
-- requirements installed.
--
-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
