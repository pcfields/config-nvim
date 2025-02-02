--------------------------------------------------------------
-- THEME: NightFox
-- URL: https://github.com/EdenEast/nightfox.nvim
-- options >>  nightfox | carbonfox | duskfox
--------------------------------------------------------------

return {
	"EdenEast/nightfox.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("nightfox").setup({})

		local colorscheme = "carbonfox"
		local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

		if not status_ok then
			vim.notify("colorscheme " .. colorscheme .. " not found")

			return
		end
	end,
}
