--[[
Description: 
barbar.nvim is a tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode. 
Plus the tab names are made unique when two filenames match.

Link: 
    https://github.com/romgrk/barbar.nvim
--]] --
--
local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
    return
end

bufferline.setup {
    icon_separator_active = '',
    icon_separator_inactive = ''
}

vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function()
        if vim.bo.filetype == 'NvimTree' then
            require'bufferline.api'.set_offset(31, 'FileTree')
        end
    end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
    pattern = '*',
    callback = function()
        if vim.fn.expand('<afile>'):match('NvimTree') then
            require'bufferline.api'.set_offset(0)
        end
    end
})
