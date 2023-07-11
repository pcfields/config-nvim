-- [[ Basic Keymaps ]]
local map = require('pcfields.utils').map
   
-- Keymaps for better default experiencep
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

--------------------------------------------------------------------------------------------
-- Files + Buffers -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Save file
map({"n", "v",  "s" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "File [s]ave" })

-- Close file
map({"n", "v",  "s" }, "<leader>fd", "<cmd>bdelete<cr>", { desc = "[F]ile close buffer" })

-- Rename file
map("n", "<leader>fr", vim.lsp.buf.rename, { desc = "[F]ile [r]ename" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "[F]ile [n]ew " })

-- Format file
map("n", "<leader>ff", "<cmd>Format<cr>", { desc = "[F]ile [f]ormat" })

-- File explorer
map("n", "<leader>fe", "<cmd>:NeoTreeFloatToggle<cr>", { desc = "[F]ile [e]xplorer" })

-- buffers
map("n", "<leader>nn", "<cmd>bnext<cr>", { desc = "[N]ext buffer" })
map("n", "<leader>pp", "<cmd>bprevious<cr>", { desc = "[P]revious buffer" })
map("n", "<leader>db", "<cmd>bdelete<cr>", { desc = "[D]elete [b]uffer" })

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

--------------------------------------------------------------------------------------------
-- Quit All
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "[Q]uit all" })
-- Quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- Exit insert mode
map("i", "jj", "<esc>", { desc = "Exit insert mode" })

-- -- better indenting
map({'n','v'}, "<", "<gv")
map({'n','v'}, ">", ">gv")

-- Move to window using the <ctrl> hjkl keys --------------------------------------------------------------------------------------------
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys --------------------------------------------------------------------------------------------
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines --------------------------------------------------------------------------------------------
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })

map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })

map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })



-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })


-- terminal
local terminalOptions = {
  buffer = 0
}

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
map("n", "<C-\\>", "<cmd>:ToggleTerm<cr>", { desc = "Open ToggleTerm" })

--------------------------------------------------------------------------------------------
-- Open things -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--- Trouble
map("n", "<leader>od", "<cmd>TroubleToggle<cr>", { desc = "[Open] [d]iagnostics" })

--- Plugin Manager
map("n", "<leader>ol", "<cmd>:Lazy<cr>", { desc = "[Open] [L]azy plugin manager" })

-- Lazygit
map("n", "<leader>og", "<cmd>:LazyGit<cr>", { desc = "[O]pen Lazy[G]it" })

-- Code action
map("n", "<leader>oa", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

-- Display Lazy Plugin manager
map("n", "<leader>ol", "<cmd>:Lazy<cr>", { desc = "[P]lugin [m]anager" })

-- Display location list
map("n", "<leader>oll", "<cmd>lopen<cr>", { desc = "Location List" })

-- Display quickfix list
map("n", "<leader>oqf", "<cmd>copen<cr>", { desc = "Quickfix List" })


-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })

-- Testing
map('n', '<leader>tn', '<cmd>:lua require"jester".run()<cr>', { desc = "Run nearest test" })