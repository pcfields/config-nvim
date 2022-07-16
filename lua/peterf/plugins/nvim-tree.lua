--[[
Description: 
    A File Explorer For Neovim Written In Lua
Link: 
    https://github.com/kyazdani42/nvim-tree.lua
--]] -- 
--
require("nvim-tree").setup({
    open_on_setup = true,
    actions = {
        open_file = {
            quit_on_open = true
        }
    }
})
