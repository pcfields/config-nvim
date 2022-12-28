local keymap = vim.api.nvim_set_keymap
local opts = {
    noremap = true,
    silent = true
}

local term_opts = {
    silent = true
}

local mode = {
    normal = 'n',
    insert = 'i',
    visual = 'v',
    visual_block = 'x',
    term = 't',
    command = 'c'
}

vim.g.mapleader = ' ' -- 'vim.g' sets global variables

-- Save file
keymap(mode.normal, '<leader>w', ':w<CR>', opts)

-- File Explorer 
keymap(mode.normal, '<leader>e', ':NvimTreeToggle<CR>', opts)

-- File Search / Telescope  
keymap(mode.normal, '<leader>sf', '<cmd>Telescope find_files<CR>', opts)
keymap(mode.normal, '<leader>sg', '<cmd>Telescope live_grep<CR>', opts)
keymap(mode.normal, '<leader>sb', '<cmd>Telescope buffers<CR>', opts)
keymap(mode.normal, '<leader>sh', '<cmd>Telescope help_tags<CR>', opts)

-- Trouble diagnostics 
keymap(mode.normal, "<leader>xx", "<cmd>Trouble<cr>", opts)
keymap(mode.normal, "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
keymap(mode.normal, "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
keymap(mode.normal, "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
keymap(mode.normal, "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
keymap(mode.normal, "gR", "<cmd>Trouble lsp_references<cr>", opts)

-- Toggle term
keymap(mode.normal, "<leader>tt", ":ToggleTerm", opts)

-- Testing
keymap(mode.normal, "<leader>tn", ":TestNearest<CR>", opts)
keymap(mode.normal, "<leader>tf", ":TestFile<CR>", opts)
keymap(mode.normal, "leader>ts", ":TestSuite<CR>", opts)
keymap(mode.normal, "<leader>tl", ":TestLast<CR>", opts)

-- Tabs/buffers
keymap(mode.normal, '<leader>p', '<Cmd>BufferPrevious<CR>', opts)
keymap(mode.normal, '<leader>n', '<Cmd>BufferNext<CR>', opts)

-- -- Normal --
-- -- Better window navigation
keymap(mode.normal, "<C-h>", "<C-w>h", opts)
keymap(mode.normal, "<C-j>", "<C-w>j", opts)
keymap(mode.normal, "<C-k>", "<C-w>k", opts)
keymap(mode.normal, "<C-l>", "<C-w>l", opts)

-- -- Insert --
-- -- Press jj fast to exit 
keymap(mode.insert, "jj", "<ESC>", opts)

-- -- Resize with arrows
-- keymap(mode.normal, "<C-Up>", ":resize -2<CR>", opts)
-- keymap(mode.normal, "<C-Down>", ":resize +2<CR>", opts)
-- keymap(mode.normal, "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap(mode.normal, "<C-Right>", ":vertical resize +2<CR>", opts)

-- -- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- -- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- -- Visual --
-- -- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- -- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- -- Visual Block --
-- -- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- -- Terminal --
-- -- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts
