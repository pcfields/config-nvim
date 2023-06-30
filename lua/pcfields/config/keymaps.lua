-- [[ Basic Keymaps ]]
local map = require('pcfields.utils').map
   
-- Keymaps for better default experiencep
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- See `:help K` for why this keymap
map('n', 'K', vim.lsp.buf.hover, { desc = "LSP: Hover Documentation" })
map('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation" })


-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- Files --------------------------------------------------------------------------------------------

-- save file
map({"n", "v",  "s" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "[F]ile [s]ave" })

-- Rename file
map("n", "<leader>fr", vim.lsp.buf.rename, { desc = "[F]ile [r]ename" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "[F]ile [n]ew " })

-- format file
map("n", "<leader>ff", "<cmd>Format<cr>", { desc = "[F]ile [f]ormat" })

-- File explorer
map("n", "<leader>fe", "<cmd>:Neotree toggle<cr>", { desc = "[F]ile [e]xplorer" })

--------------------------------------------------------------------------------------------

-- Quit All
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "[Q]uit all" })

map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })

-- Exit insert mode
map("i", "jj", "<esc>", { desc = "Exit insert mode" })

-- -- better indenting
map({'n','v'}, "<", "<gv")
map({'n','v'}, ">", ">gv")


-- Code action
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

-- Display Lazy Plugin manager
map("n", "<leader>pm", "<cmd>:Lazy<cr>", { desc = "[P]lugin [m]anager" })



-- Display location list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })

-- Display quickfix list
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

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
--------------------------------------------------------------------------------------------
-- Lazygit
map("n", "<leader>og", "<cmd>:LazyGit<cr>", { desc = "[O]pen Lazy[G]it" })

-- buffers
map("n", "<leader><tab><tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader><tab>n", "<cmd>bnext<cr>", { desc = "[N]ext buffer" })
map("n", "<leader><tab>p", "<cmd>bprevious<cr>", { desc = "[P]revious buffer" })
map("n", "<leader><tab>d", "<cmd>bdelete<cr>", { desc = "[D]elete [b]uffer" })


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

-- toggleTerminal
map("n", "<leader>tt", "<cmd>:ToggleTerm<cr>", { desc = "Open ToggleTerm" })

-- terminal
local terminalOptions = {
  buffer = 0
}

map('t', '<esc>', [[<C-\><C-n>]], terminalOptions)
map('t', 'jk', [[<C-\><C-n>]], terminalOptions)
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], terminalOptions)
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], terminalOptions)
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], terminalOptions)
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], terminalOptions)
map('t', '<C-w>', [[<C-\><C-n><C-w>]], terminalOptions)

--- Trouble
map("n", "<leader>od", "<cmd>TroubleToggle<cr>", { desc = "[Open] [d]iagnostics"})

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })

-- Testing

map('n', '<leader>tn', '<cmd>:lua require"jester".run()<cr>', { desc = "Run nearest test" })
