-- [[ Basic Keymaps ]]
local map = require('pcfields.utils').map
-- Keymaps for better default experiencep
-- See `:help vim.keymap.set()`
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear search with <esc>
map({ 'i', 'n', 'v' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })
map({ 'i', 'n', 'v' }, '<C-e>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Clear search, diff update and redraw
map('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

-- Search word under cursor
map({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

--------------------------------------------------------------------------------------------
-- Files + Buffers -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

-- Save file
map({ 'n', 'v', 's' }, '<leader>fs', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- New file
map('n', '<leader>nf', '<cmd>enew<cr>', { desc = 'File new ' })

-- File explorer
map('n', '<leader>fw', '<cmd>Neotree toggle reveal=true<cr>', { desc = 'File explorer' })

-- File Explorer git status
map('n', '<leader>fg', '<cmd>:Neotree git_status<cr>', { desc = 'File git status' })

-- Select all text in buffer
map('n', '<leader>aa', 'gg<S-v>G', { desc = 'Select all text in buffer' })

-- Next buffer
map('n', '<A-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- Previous buffer
map('n', '<A-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })

-- Close buffer
map('n', '<leader>xx', '<cmd>:bd<cr>', { desc = 'File Close buffer' })

-- Bufferline buffers
map('n', '<leader>bb', '<cmd>:BufferLinePick<cr>', { desc = 'Select a buffer with letter' })

map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', { desc = 'Go to buffer 1' })
map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', { desc = 'Go to buffer 2' })
map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', { desc = 'Go to buffer 3' })
map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', { desc = 'Go to buffer 4' })
map('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>', { desc = 'Go to buffer 5' })
map('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<cr>', { desc = 'Go to buffer 6' })
map('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<cr>', { desc = 'Go to buffer 7' })
map('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<cr>', { desc = 'Go to buffer 8' })
map('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<cr>', { desc = 'Go to buffer 9' })

map('n', '<leader>0', '<cmd>BufferLineGoToBuffer -1<cr>', { desc = 'Go to last buffer' })

-- Close all buffers to the RIGHT
map('n', '<leader>bl', '<cmd>BufferLineCloseRight<cr>', { desc = 'Close all buffers to the RIGHT' })

-- Close all buffer to the LEFT
map('n', '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Close all buffer to the LEFT' })

-- Close all other buffers
map('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Close all other buffers' })

-- windows
map('n', '<leader>ww', '<C-w>p', { desc = 'Other window' })
map('n', '<leader>wx', '<C-w>c', { desc = 'Delete window' })
map('n', '<leader>wn', '<C-w>n', { desc = 'Create new window' })

-- Move to window using the <ctrl> hjkl keys
map('n', '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
map('n', '<leader>wj', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<leader>wk', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<leader>wl', '<C-w>l', { desc = 'Go to right window' })

-- Split windows
map('n', '<leader>wb', '<C-w>s', { desc = 'Split window below' })
map('n', '<leader>wr', '<C-w>v', { desc = 'Split window right' })

-- Resize windows 50/50
map('n', '<leader>w2', '<C-w>=', { desc = 'Resize windows to be 50|50' })

-- Resize window using <ctrl> arrow keys --------------------------------------------------------------------------------------------
-- Height
map('n', '<C-Up>', '<cmd>resize +4<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -4<cr>', { desc = 'Decrease window height' })

-- Vertical Width small adjustment
map('n', '<C-Left>', '<cmd>vertical resize +4<cr>', { desc = 'Increase window width' })
map('n', '<C-Right>', '<cmd>vertical resize -4<cr>', { desc = 'Decrease window width' })

--------------------------------------------------------------------------------------------
-- Quit All
map('n', '<leader>xa', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Quit
map('n', '<leader>xc', '<cmd>q<cr>', { desc = 'Quit' })

-- Exit insert mode
map('i', 'jj', '<esc>', { desc = 'Exit insert mode' })
map('i', 'jk', '<esc>', { desc = 'Exit insert mode' })

-- Line movement - left, right
map({ 'n', 'v' }, '<leader>hh', '^', { desc = 'Go to beginning of line' })
map({ 'n', 'v' }, '<leader>ll', '$', { desc = 'Go to end of line' })

-- Line movement - top, bottom
map({ 'n', 'v' }, '<leader>kk', 'gg', { desc = 'Go to top of file' })
map({ 'n', 'v' }, '<leader>jj', '<S-g>', { desc = 'Go to bottom of file' })

-- Move Lines --------------------------------------------------------------------------------------------
-- Move down
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })

-- Move up
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- highlights under cursor
if vim.fn.has 'nvim-0.9.0' == 1 then
    map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
end

-- terminal
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-e>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jj', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

--------------------------------------------------------------------------------------------
-- Open things -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Open Lazygit
map('n', '<leader>gg', '<cmd>:LazyGit<cr>', { desc = 'Open LazyGit' })
-- Open Plugin Manager
map('n', '<C-p>', '<cmd>:Lazy<cr>', { desc = 'Open Lazy Plugin Manager' })

-- Diagnostic keymaps
map('n', '<leader>dj', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
map('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
map('n', '<leader>di', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic info message' })
map('n', '<leader>df', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Trouble: Buffer/[f]ile [d]iagnostics' })
map('n', '<leader>da', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: [A]ll open Buffer [d]iagnostics' })

map('n', '<leader>os', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: [O]pen [s]ymbols diagnostics ' })
map('n', '<leader>ol', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Trouble: [O]pen [L]SP diagnostics' })

--- Code changes
-- Rename variable
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable' })

-- Code action
map('n', '<leader>ka', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Twilight highlights current block and dims other code
map('n', '<leader>kt', '<cmd>Twilight<cr>', { desc = 'Turn on Twilight' })

-- Code folding
map('n', '<leader>kf', 'za', { desc = 'Code folding' })

--Todo comments in telescope
map('n', '<leader>lt', '<cmd>:TodoTelescope<cr>', { desc = 'Display all todo comments in telescope' })
