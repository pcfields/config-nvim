--[[
Description: 
    A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
Link: 
    https://github.com/folke/trouble.nvim
--]] --
-- 
local status_ok, trouble = pcall(require, 'trouble')
if not status_ok then
    return
end

trouble.setup {}
