local Snacks = require('snacks')

local M = {}

M.ViewOpenBuffers = function()
    Snacks.picker.buffers()
end

M.SearchGrep = function()
    Snacks.picker.grep()
end

M.SearchFiles = function()
    Snacks.picker.files()
end

M.SearchGitFiles = function()
    Snacks.picker.git_files()
end

M.SearchRecentFiles = function()
    Snacks.picker.recent()
end

M.SearchGrepWord = function()
    Snacks.picker.grep_word()
end

M.GitFileLog = function()
    Snacks.picker.git_log_file()
end

M.OpenLazyGit = function()
    Snacks.lazygit()
end

M.GitLogHistory = function()
    Snacks.picker.git_log()
end

M.GitStatus = function()
    Snacks.picker.git_status()
end

M.GitDiffList = function()
    Snacks.picker.git_diff()
end

M.ListGitBranches = function()
    Snacks.picker.git_branches()
end

M.SearchHelpPages = function()
    Snacks.picker.help()
end

M.GotoDefinition = function()
    Snacks.picker.lsp_definitions()
end

M.GotoImplementation = function()
    Snacks.picker.lsp_implementations()
end

M.SearchDiagnosticsBuffer = function()
    Snacks.picker.diagnostics_buffer()
end

M.SearchAllDiagnostics = function()
    Snacks.picker.diagnostics()
end

M.GotoReferences = function()
    Snacks.picker.lsp_references()
end

M.ListLSPSymbols = function()
    Snacks.picker.lsp_symbols()
end

M.GotoTypeDefinition = function()
    Snacks.picker.lsp_type_definitions()
end

M.SearchMarks = function()
    Snacks.picker.marks()
end

M.SearchJumps = function()
    Snacks.picker.jumps()
end

M.DisplayRegisters = function()
    Snacks.picker.registers()
end

M.Explorer = function()
    Snacks.explorer()
end

return M
