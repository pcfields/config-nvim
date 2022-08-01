--[[
Description:
    A blazing fast and easy to configure Neovim statusline written in Lua.
Link:
    https://github.com/nvim-lualine/lualine.nvim
--]] --
--
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = {
            left = '',
            right = ''
        },
        section_separators = {
            left = '',
            right = ''
        },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false
    }
}
