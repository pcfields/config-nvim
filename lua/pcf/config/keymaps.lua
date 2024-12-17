-- [[ Basic Keymaps ]]
local map = require('pcf.utils').map
local perform_action_on_node = require('pcf.utils').perform_action_on_node
local play_macro = require('pcf.utils').play_macro
local record_macro = require('pcf.utils').record_macro

-- Keymaps for better default experiencep
-- See `:help vim.keymap.set()`
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear search with <esc>
map({ 'i', 'n', 'v' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Clear search, diff update and redraw
map({ 'n' }, '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

-- Search word under cursor
map({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

-- Fix copy and paste, keep the copied text instead of keeping the text pasted over
-- map({ 'x' }, 'p', [["_dP]]) -- TODO: understand what this actually does
map({ 'n' }, '<leader>xn', '<cmd>Noice dismiss<cr>', { desc = 'Dismiss all notifications' })

--------------------------------------------------------------------------------------------
-- Files  -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>ss', '/', { desc = 'Search', noremap = true, silent = false })
map({ 'n', 'v', 's' }, '<leader>fs', '<cmd>w<cr><esc>', { desc = 'Save file' })
map({ 'n' }, '<leader>nf', '<cmd>enew<cr>', { desc = 'File new ' })
-- map({ 'n' }, '<leader>cfn', '<cmd>expand("%:t")', { desc = 'Copy filename' })
-- map({ 'n' }, '<leader>cfp', '<cmd>expand("%:p")', { desc = 'Copy file path' })

--------------------------------------------------------------------------------------------
-- File explorer -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>fw', '<cmd>Neotree toggle reveal=true<cr>', { desc = 'File explorer' })
map({ 'n' }, '<leader>fg', '<cmd>Neotree git_status<cr>', { desc = 'File git status' })
map({ 'n' }, '<leader>aa', 'gg<S-v>G', { desc = 'Select all text in buffer' })

--------------------------------------------------------------------------------------------
-- Buffers ----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>xx', '<cmd>:bd<cr>', { desc = 'Close buffer' })
map({ 'n' }, '<A-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map({ 'n' }, '<A-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map({ 'n' }, '<leader>vk', '<cmd>e #<cr>', { desc = 'Switch to last used buffer' })
map({ 'n' }, '<leader>vc', [[:%bdelete|edit #|bdelete #<CR>]], { desc = 'Delete all buffers except current buffer', noremap = true, silent = true })

--------------------------------------------------------------------------------------------
-- Windows ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>ww', '<C-w>p', { desc = 'Other window' })
map({ 'n' }, '<leader>wx', '<C-w>c', { desc = 'Delete window' })
map({ 'n' }, '<leader>wn', '<C-w>n', { desc = 'Create new window' })

-- Move to window using the <ctrl> hjkl keys
map({ 'n' }, '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
map({ 'n' }, '<leader>wj', '<C-w>j', { desc = 'Go to lower window' })
map({ 'n' }, '<leader>wk', '<C-w>k', { desc = 'Go to upper window' })
map({ 'n' }, '<leader>wl', '<C-w>l', { desc = 'Go to right window' })

-- Split windows
map({ 'n' }, '<leader>ws', '<C-w>s', { desc = 'Split window below' })
map({ 'n' }, '<leader>wv', '<C-w>v', { desc = 'Split window right' })

-- Resize windows 50/50
map({ 'n' }, '<leader>w2', '<C-w>=', { desc = 'Resize windows to be 50|50' })

--------------------------------------------------------------------------------------------
-- Resize ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
map({ 'n' }, '<C-Up>', '<cmd>resize +4<cr>', { desc = 'Increase window height' })
map({ 'n' }, '<C-Down>', '<cmd>resize -4<cr>', { desc = 'Decrease window height' })
map({ 'n' }, '<C-Left>', '<cmd>vertical resize +4<cr>', { desc = 'Increase window width' })
map({ 'n' }, '<C-Right>', '<cmd>vertical resize -4<cr>', { desc = 'Decrease window width' })

--------------------------------------------------------------------------------------------
map({ 'n' }, '<leader>xa', '<cmd>qa<cr>', { desc = 'Quit all, Close Neovim' })
map({ 'n' }, '<leader>xc', '<cmd>q<cr>', { desc = 'Quit' })
map('i', '<leader><leader>', '<esc>', { desc = 'Exit insert mode' })

--------------------------------------------------------------------------------------------
-- Line movement ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Move up one line and manage word wrap', expr = true, silent = true })
map({ 'n' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Move down one line and manage word wrap', expr = true, silent = true })
map({ 'n' }, 'n', 'nzz', { desc = 'Go to next and center cursor in middle of screen' })
map({ 'n' }, 'N', 'Nzz', { desc = 'Go to previous and center cursor in middle of screen' })
map({ 'n' }, '*', '*zz', { desc = 'Search forward for the word under the cursor and center cursor in middle of screen' })
map({ 'n' }, '#', '#zz', { desc = 'Search backward and center cursor in middle of screen' })
map({ 'n' }, 'g*', 'g*zz', { desc = 'Search forward for the word under the cursor and center cursor in middle of screen' })
map({ 'n' }, 'g#', 'g#zz', { desc = 'Search backward and center cursor in middle of screen' })

-- Horizontal line movement
map({ 'n', 'v' }, '<leader>jh', '^', { desc = 'Go to beginning of line' })
map({ 'n', 'v' }, '<leader>jl', '$', { desc = 'Go to end of line' })
map({ 'n', 'v' }, '<leader>jb', '%', { desc = 'Find the next (curly/square) bracket on this line and go to its match' })
map({ 'n' }, '<leader>de', 'd$', { desc = 'Delete to end of line' })

-- Vertical line movement
map({ 'n', 'v' }, '<leader>ju', 'gg', { desc = 'Go to top of buffer' })
map({ 'n', 'v' }, '<leader>jn', '<S-g>', { desc = 'Go to bottom of buffer' })

-- Move line down
map({ 'n' }, '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })

-- Move line up
map({ 'n' }, '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- terminal
function _G.set_terminal_keymaps()
    local terminal_opts = { buffer = 0 }

    vim.keymap.set('t', '<C-e>', [[<C-\><C-n>]], terminal_opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], terminal_opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], terminal_opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], terminal_opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], terminal_opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], terminal_opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], terminal_opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

--------------------------------------------------------------------------------------------
-- Open things -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
map({ 'n' }, '<leader>gg', '<cmd>:LazyGit<cr>', { desc = 'Open LazyGit' })
map({ 'n' }, '<C-p>', '<cmd>:Lazy<cr>', { desc = 'Open Lazy Plugin Manager' })

--------------------------------------------------------------------------------------------
-- Diagnostics/Errors  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>ej', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic [e]rror message' })
map({ 'n' }, '<leader>ek', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic [e]rror message' })
map({ 'n' }, '<leader>ei', vim.diagnostic.open_float, { desc = 'Open floating diagnostic [e]rror info message' })
map({ 'n' }, '<leader>ef', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Trouble: Buffer/[f]ile [d]iagnostics' })
map({ 'n' }, '<leader>ea', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: [A]ll open Buffer [d]iagnostics' })

--------------------------------------------------------------------------------------------
-- Refactor  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>rn', vim.lsp.buf.rename, { desc = 'Refactor: Rename variable' })
map({ 'n', 'x' }, '<leader>rr', function()
    require('refactoring').select_refactor {}
end, { desc = 'Prompt for a refactor to apply when the remap is triggered' })

--------------------------------------------------------------------------------------------
--  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>ka', vim.lsp.buf.code_action, { desc = 'Code action' })
map({ 'n' }, '<leader>kf', 'za', { desc = 'Code folding' })
map({ 'n' }, '<leader>lt', '<cmd>:TodoTelescope<cr>', { desc = 'Display all todo comments in telescope' })

map({ 'n', 'v' }, '<leader>ye', 'y$', { desc = 'Yank till end of line' })
map({ 'n', 'v' }, '<leader>yii', function()
    perform_action_on_node 'yi'
end, { desc = 'Yank inside (...) or [...] or {...} or "..." ' })

-- map({ 'n', 'v' }, '<leader>yif', function()
--     perform_action_on_node 'yii'
-- end, { desc = 'Yank inside (...) or [...] or {...} or "..." ' })

map({ 'n', 'v' }, '<leader>yaa', function()
    perform_action_on_node 'ya'
end, { desc = 'Yank around (...) or [...] or {...} or "..." ' })

map({ 'n', 'v' }, '<leader>dii', function()
    perform_action_on_node 'di'
end, { desc = 'Delete inside (...) or [...] or {...} or "..." ' })

map({ 'n', 'v' }, '<leader>daa', function()
    perform_action_on_node 'da'
end, { desc = 'Delete around (...) or [...] or {...} or "..." ' })

--------------------------------------------------------------------------------------------
-- Macros  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>mp', play_macro, { noremap = true, silent = true, desc = 'Play a macro from a specified register' })
map({ 'n' }, '<leader>mr', record_macro, { noremap = true, silent = true, desc = 'Record a macro in a specified register' })
