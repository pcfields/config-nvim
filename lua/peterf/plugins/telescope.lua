--[[
Description:
    telescope.nvim is a highly extendable fuzzy finder over lists.
Link:         
    https://github.com/nvim-telescope/telescope.nvim
--]] --
local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_ignore_patterns = {"node_modules"}
    }
}
-- telescope.load_extension('fzf')
