-- [[ Basic Keymaps ]]
local map = require('pcfields.utils').map
   
-- Keymaps for better default experiencep
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

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
map({ "i", "v", "n", "s" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Rename file
map("n", "<leader>fr", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- File explorer
map("n", "<leader>fe", "<cmd>:Neotree toggle<cr>", { desc = "File explorer" })

--------------------------------------------------------------------------------------------

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Exit insert mode
map("i", "<A-n>", "<esc>", { desc = "Exit insert mode" })

-- -- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")


-- Code action
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

-- Display Lazy Plugin manager
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })



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

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- buffers
-- if Util.has("bufferline.nvim") then
--   map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--   map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- else
--   map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--   map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--   map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--   map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- end

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

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })


-- toggleTerminal
map("n", "<leader>tt", "<cmd>:ToggleTerm<cr>", { desc = "Split window right" })

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
