-- Code Folding------------------------------
-- https://github.com/kevinhwang91/nvim-ufo#table-of-contents

-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`

return { -- Improved code folding
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})

		vim.keymap.set("n", "<leader>ko", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "<leader>kc", require("ufo").closeAllFolds, { desc = "Close all folds" })
	end,
}
