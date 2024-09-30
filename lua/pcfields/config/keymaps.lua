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

-- Clear search with <esc>
map({ 'i', 'n', 'v' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Clear search, diff update and redraw
map({ 'n' }, '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

-- Search word under cursor
map({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

map({ 'x' }, 'p', [["_dP]]) -- Fix copy and paste, keep the copied text instead of keeping the text pasted over

--------------------------------------------------------------------------------------------
-- Files  -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>ss', '/', { desc = 'Search', noremap = true, silent = false })
map({ 'n', 'v', 's' }, '<leader>fs', '<cmd>w<cr><esc>', { desc = 'Save file' })
map({ 'n' }, '<leader>nf', '<cmd>enew<cr>', { desc = 'File new ' })

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
map({ 'n' }, '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map({ 'n' }, '<leader>bo', [[:%bdelete|edit #|bdelete #<CR>]], { desc = 'Delete all buffers except current buffer', noremap = true, silent = true })

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
map({ 'n' }, '<leader>wb', '<C-w>s', { desc = 'Split window below' })
map({ 'n' }, '<leader>wr', '<C-w>v', { desc = 'Split window right' })

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
map('i', 'jk', '<esc>', { desc = 'Exit insert mode' })

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
map({ 'n', 'v' }, '<leader>ju', 'gg', { desc = 'Go to top of file' })
map({ 'n', 'v' }, '<leader>jn', '<S-g>', { desc = 'Go to bottom of file' })

-- Move line down
map({ 'n' }, '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })

-- Move line up
map({ 'n' }, '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- highlights under cursor
if vim.fn.has 'nvim-0.9.0' == 1 then
    map({ 'n' }, '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
end

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
-- Diagnostics  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>dj', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
map({ 'n' }, '<leader>dk', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
map({ 'n' }, '<leader>di', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic info message' })
map({ 'n' }, '<leader>df', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Trouble: Buffer/[f]ile [d]iagnostics' })
map({ 'n' }, '<leader>da', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: [A]ll open Buffer [d]iagnostics' })
-- map({ 'n' }, '<leader>os', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: [O]pen [s]ymbols diagnostics ' })
-- map({ 'n' }, '<leader>ol', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Trouble: [O]pen [L]SP diagnostics' })

--------------------------------------------------------------------------------------------
-- Refactor  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ 'n' }, '<leader>rn', vim.lsp.buf.rename, { desc = 'Refactor: Rename variable' })
map({ 'x' }, '<leader>re', ':Refactor extract ', { desc = 'Refactor: Extract' })
map({ 'x' }, '<leader>rf', ':Refactor extract_to_file ', { desc = 'Refactor: Extract to file' })
map({ 'x' }, '<leader>rv', ':Refactor extract_var ', { desc = 'Refactor: Extract variable' })
map({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var', { desc = 'Refactor: Inline variable' })
map({ 'n' }, '<leader>rI', ':Refactor inline_func', { desc = 'Refactor: Inline function' })
map({ 'n' }, '<leader>rb', ':Refactor extract_block', { desc = 'Refactor: Extract block' })
map({ 'n' }, '<leader>rbf', ':Refactor extract_block_to_file', { desc = 'Refactor: extract block to file' })

--------------------------------------------------------------------------------------------
-- Refactor  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Code action
map({ 'n' }, '<leader>ka', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Twilight highlights current block and dims other code
map({ 'n' }, '<leader>kt', '<cmd>Twilight<cr>', { desc = 'Turn on Twilight' })

-- Code folding
map({ 'n' }, '<leader>kf', 'za', { desc = 'Code folding' })

--Todo comments in telescope
map({ 'n' }, '<leader>lt', '<cmd>:TodoTelescope<cr>', { desc = 'Display all todo comments in telescope' })
