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
map({ "i", "n", "v" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "i", "n", "v" }, "<C-e>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

--------------------------------------------------------------------------------------------
-- Files + Buffers -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Save file
map({"n", "v", "s" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "File save" })
-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "[F]ile [n]ew " })
-- Format file
map("n", "<leader>ff", "<cmd>Format<cr>", { desc = "[F]ile [f]ormat" })
-- File explorer
map("n", "<leader>fe", "<cmd>:Neotree toggle<cr>", { desc = "[F]ile [e]xplorer" })

-- buffers
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Bufferline buffers
map("n", "<leader>sb", "<cmd>:BufferLinePick<cr>", { desc = "[S]elect a [b]uffer" })
map("n", "<leader>1","<cmd>BufferLineGoToBuffer 1<cr>", { desc= "Go to buffer 1"})
map("n", "<leader>2","<cmd>BufferLineGoToBuffer 2<cr>", { desc= "Go to buffer 2"})
map("n", "<leader>3","<cmd>BufferLineGoToBuffer 3<cr>", { desc= "Go to buffer 3"})
map("n", "<leader>4","<cmd>BufferLineGoToBuffer 4<cr>", { desc= "Go to buffer 4"})
map("n", "<leader>5","<cmd>BufferLineGoToBuffer 5<cr>", { desc= "Go to buffer 5"})
map("n", "<leader>6","<cmd>BufferLineGoToBuffer 6<cr>", { desc= "Go to buffer 6"})
map("n", "<leader>7","<cmd>BufferLineGoToBuffer 7<cr>", { desc= "Go to buffer 7"})
map("n", "<leader>8","<cmd>BufferLineGoToBuffer 8<cr>", { desc= "Go to buffer 8"})
map("n", "<leader>9","<cmd>BufferLineGoToBuffer 9<cr>", { desc= "Go to buffer 9"})
map("n", "<leader>0","<cmd>BufferLineGoToBuffer -1<cr>", { desc= "Go to last buffer"})

-- windows
map("n", "<leader>ww", "<C-w>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>wn", "<C-w>n", { desc = "Create new window" })
-- Move to window using the <ctrl> hjkl keys
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window" })
-- Split windows
map("n", "<leader>wb", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>wr", "<C-w>v", { desc = "Split window right" })
-- Resize windows
map("n", "<leader>w2", "<C-w>=", { desc = "Resize windows to be 50|50" })
-- Resize window using <ctrl> arrow keys --------------------------------------------------------------------------------------------
-- Height
map("n", "<C-Up>", "<cmd>resize +4<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -4<cr>", { desc = "Decrease window height" })
-- Vertical Width small adjustment
map("n", "<C-Left>", "<cmd>vertical resize +4<cr>", { desc = "Increase window width" })
map("n", "<C-Right>", "<cmd>vertical resize -4<cr>", { desc = "Decrease window width" })
-- Rename variable
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })

-- Code action
map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })

--------------------------------------------------------------------------------------------
-- Quit All
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "[Q]uit all" })
-- Quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- Exit insert mode
map("i", "jj", "<esc>", { desc = "Exit insert mode" })


-- Line movement
map({'n','v'}, "mh", "^", { desc = "Go to beginning of line" })
map({'n','v'}, "ml", "$", { desc = "Go to end of line" })

-- Move Lines --------------------------------------------------------------------------------------------

-- Move down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- Move up
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end



-- terminal
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- toggleTerminal
map("n", "<C-t>", "<cmd>:ToggleTerm<cr>", { desc = "Open ToggleTerm" })

--------------------------------------------------------------------------------------------
-- Open things -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--- TroubleToggle
map("n", "<leader>od", "<cmd>TroubleToggle<cr>", { desc = "[Open] [d]iagnostics" })

--- Plugin Manager
map("n", "<leader>ol", "<cmd>:Lazy<cr>", { desc = "[Open] [L]azy plugin manager" })

-- Display location list
-- map("n", "<leader>oll", "<cmd>lopen<cr>", { desc = "Location List" })

-- Lazygit
map("n", "<leader>og", "<cmd>:LazyGit<cr>", { desc = "[O]pen Lazy[G]it" })


-- Display quickfix list
map("n", "<leader>oq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Diagnostic keymaps
map('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
map('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })

-- Testing
map('n', '<leader>tn', '<cmd>:lua require"jester".run()<cr>', { desc = "Run nearest test" })
