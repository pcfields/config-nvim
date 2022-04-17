local options = {
    noremap = true,
    silent = true
}
local term_options = {
    silent = true
}
local keymap = vim.api.nvim_set_keymap

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

-- Remap space as leader key
keymap("", "<Space>", "Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- File explorer
keymap("n", "<leader> e", ":Lex", options)

keymap("n", "<C-Up>", ":resize +2<CR>", options)
keymap("n", "<C-Down>", ":resize -2<CR>", options)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", options)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", options)
