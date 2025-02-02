-- [[ Basic Keymaps ]]
local pcf_utils = require("pcf.utils")

local map = pcf_utils.map
local execute_command_on_enclosing_node = pcf_utils.execute_command_on_enclosing_node
local play_macro = pcf_utils.play_macro
local record_macro = pcf_utils.record_macro
local yank_register = '"z'
-- NOTE: I am using 'z' register for yanking and pasting

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search with <esc>
map({ "i", "n", "v" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
map({ "n" }, "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Search word under cursor
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

map({ "n" }, "<leader>xn", "<cmd>Noice dismiss<cr>", { desc = "Dismiss all notifications" })

--------------------------------------------------------------------------------------------
-- Files  -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "<leader>ss", "/", { desc = "Search", silent = false })
map({ "n", "v", "s" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "n" }, "<leader>nf", "<cmd>enew<cr>", { desc = "File new " })

-- Copy
map({ "n" }, "<leader>cfn", [[<cmd>lua vim.fn.setreg('+', vim.fn.expand('%:t'))<CR>]], { desc = "Copy filename" })
map({ "n" }, "<leader>cfp", [[<cmd>lua vim.fn.setreg('+', vim.fn.expand('%:p'))<CR>]], { desc = "Copy file path" })
map({ "n" }, "<leader>ca", ":%y+<CR>", { desc = "Copy all text in buffer to clipboard" })

-- Overwrite default yank and paste to use z register
map({ "n", "v" }, "y", yank_register .. "y", { desc = "Yank to [" .. yank_register .. "] register" })
map({ "n", "v" }, "p", yank_register .. "p", { desc = "Paste from [" .. yank_register .. "] register" })
map({ "n", "v" }, "d", '"_d', { desc = "Delete without copying to register" })
map({ "n", "v" }, "<leader>dd", yank_register .. "d", { desc = "Delete and copy to [" .. yank_register .. "] register" })

-- Clipboard copy and paste
map({ "n", "v" }, "<leader>yc", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>yl", '"+yy', { desc = "Copy line to clipboard" })
map({ "n", "v" }, "<leader>pc", '"+p', { desc = "Paste from clipboard" })

--------------------------------------------------------------------------------------------
-- File explorer -----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
map({ "n" }, "<leader>fw", "<cmd>Neotree toggle reveal float<cr>", { desc = "File explorer" })
map({ "n" }, "<leader>ft", "<cmd>Neotree toggle reveal current<cr>", { desc = "File explorer in tab" })
map({ "n" }, "<leader>fg", "<cmd>Neotree git_status<cr>", { desc = "File git status" })
map({ "n" }, "<leader>aa", "gg<S-v>G", { desc = "Select all text in buffer" })

--------------------------------------------------------------------------------------------
-- Buffers ----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "<leader>xx", "<cmd>:bd<cr>", { desc = "Close buffer" })
map({ "n" }, "<A-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map({ "n" }, "<A-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map({ "n" }, "<leader>vk", "<cmd>e #<cr>", { desc = "Switch to last used buffer" })
map({ "n" }, "<leader>vc", [[:%bdelete|edit #|bdelete #<CR>]], { desc = "Delete all buffers except current buffer" })

--------------------------------------------------------------------------------------------
-- Windows ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "<leader>ww", "<C-w>p", { desc = "Other window" })
map({ "n" }, "<leader>wx", "<C-w>c", { desc = "Delete window" })
map({ "n" }, "<leader>wn", "<C-w>n", { desc = "Create new window" })

-- Move to window using the <ctrl> hjkl keys
map({ "n" }, "<leader>wh", "<C-w>h", { desc = "Go to left window" })
map({ "n" }, "<leader>wj", "<C-w>j", { desc = "Go to lower window" })
map({ "n" }, "<leader>wk", "<C-w>k", { desc = "Go to upper window" })
map({ "n" }, "<leader>wl", "<C-w>l", { desc = "Go to right window" })

-- Split windows
map({ "n" }, "<leader>ws", "<C-w>s", { desc = "Split window below" })
map({ "n" }, "<leader>wv", "<C-w>v", { desc = "Split window right" })

-- Resize windows 50/50
map({ "n" }, "<leader>w2", "<C-w>=", { desc = "Resize windows to be 50|50" })

--------------------------------------------------------------------------------------------
-- Resize ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
map({ "n" }, "<C-Up>", "<cmd>resize +4<cr>", { desc = "Increase window height" })
map({ "n" }, "<C-Down>", "<cmd>resize -4<cr>", { desc = "Decrease window height" })
map({ "n" }, "<C-Left>", "<cmd>vertical resize +4<cr>", { desc = "Increase window width" })
map({ "n" }, "<C-Right>", "<cmd>vertical resize -4<cr>", { desc = "Decrease window width" })

--------------------------------------------------------------------------------------------
map({ "n" }, "<leader>xa", "<cmd>qa<cr>", { desc = "Quit all, Close Neovim" })
map({ "n" }, "<leader>xc", "<cmd>q<cr>", { desc = "Quit" })
map("i", "<leader><leader>", "<esc>", { desc = "Exit insert mode" })

--------------------------------------------------------------------------------------------
-- Line movement ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up one line and manage word wrap", expr = true })
map({ "n" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down one line and manage word wrap", expr = true })
map({ "n" }, "n", "nzz", { desc = "Go to next and center cursor in middle of screen" })
map({ "n" }, "N", "Nzz", { desc = "Go to previous and center cursor in middle of screen" })
map({ "n" }, "*", "*zz", { desc = "Search forward for the word under the cursor and center cursor in middle of screen" })
map({ "n" }, "#", "#zz", { desc = "Search backward and center cursor in middle of screen" })
map({ "n" }, "g*", "g*zz", { desc = "Search forward for the word under the cursor and center cursor in middle of screen" })
map({ "n" }, "g#", "g#zz", { desc = "Search backward and center cursor in middle of screen" })

-- Horizontal line movement
map({ "n", "v" }, "<leader>jh", "^", { desc = "Go to beginning of line" })
map({ "n", "v" }, "<leader>jl", "$", { desc = "Go to end of line" })
map({ "n", "v" }, "<leader>jm", "%", { desc = "Jump to the next matching bracket" })
map({ "n" }, "<leader>de", "d$", { desc = "Delete to end of line" })

-- Vertical line movement
map({ "n", "v" }, "<leader>ju", "gg", { desc = "Go to top of buffer" })
map({ "n", "v" }, "<leader>jn", "<S-g>", { desc = "Go to bottom of buffer" })

-- Move line down
map({ "n" }, "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- Move line up
map({ "n" }, "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- terminal
function _G.set_terminal_keymaps()
	local terminal_opts = { buffer = 0 }

	vim.keymap.set("t", "<C-e>", [[<C-\><C-n>]], terminal_opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], terminal_opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], terminal_opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], terminal_opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], terminal_opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], terminal_opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], terminal_opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

--------------------------------------------------------------------------------------------
-- Open things -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
map({ "n" }, "<C-p>", "<cmd>:Lazy<cr>", { desc = "Open Lazy Plugin Manager" })
map({ "n" }, "<leader>gdo", "<cmd>::DiffviewOpen<cr>", { desc = "Open Git diff view" })
map({ "n" }, "<leader>gdx", "<cmd>::DiffviewClose<cr>", { desc = "Close Git diff view" })
--------------------------------------------------------------------------------------------
-- Diagnostics/Errors  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "<leader>ej", vim.diagnostic.goto_next, { desc = "Go to next diagnostic [e]rror message" })
map({ "n" }, "<leader>ek", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic [e]rror message" })
map({ "n" }, "<leader>ei", vim.diagnostic.open_float, { desc = "Open floating diagnostic [e]rror info message" })

map({ "n" }, "<leader>tef", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: File/buffer issues" })
map({ "n" }, "<leader>tea", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: All open File/buffer issues" })

--------------------------------------------------------------------------------------------
-- Refactor  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Refactor: Rename variable" })

--------------------------------------------------------------------------------------------
--  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
---
map({ "n" }, "<leader>ka", vim.lsp.buf.code_action, { desc = "Code action" })
map({ "n" }, "<leader>kf", "za", { desc = "Code folding" })

-- Yank keymaps
--
map({ "n", "v" }, "<leader>ye", yank_register .. "y$", { desc = "Yank till end of line" })

local brackets_or_strings_text = " (...) or [...] or {...} or strings"

map({ "n", "v" }, "<leader>yii", function()
	local command_yank_inside_to_register_z = yank_register .. "yi"

	execute_command_on_enclosing_node(command_yank_inside_to_register_z)
end, { desc = "Yank inside " .. brackets_or_strings_text })

map({ "n", "v" }, "<leader>yaa", function()
	local command_yank_around_to_register_z = yank_register .. "ya"

	execute_command_on_enclosing_node(command_yank_around_to_register_z)
end, { desc = "Yank around " .. brackets_or_strings_text })

map({ "n", "v" }, "<leader>dii", function()
	local command_delete_inside = "di"

	execute_command_on_enclosing_node(command_delete_inside)
end, { desc = "Delete inside " .. brackets_or_strings_text })

map({ "n", "v" }, "<leader>daa", function()
	local command_delete_around = "da"

	execute_command_on_enclosing_node(command_delete_around)
end, { desc = "Delete around " .. brackets_or_strings_text })

--------------------------------------------------------------------------------------------
-- Macros  --------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

map({ "n" }, "<leader>pm", play_macro, { desc = "Play a macro from a specified register" })
map({ "n" }, "<leader>rm", record_macro, { desc = "Record a macro in a specified register" })
