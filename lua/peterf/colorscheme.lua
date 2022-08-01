-- vim.cmd('colorscheme gruvbox-material')
local status_ok, _ = pcall(vim.cmd, "colorscheme gruvbox-material")

if not status_ok then
    return
end
