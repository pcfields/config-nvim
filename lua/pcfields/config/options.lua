-- [[ Setting options ]]
-- See `:help vim.o`
local opt = vim.opt



vim.wo.number = true -- Make line numbers default
opt.hlsearch = false -- Set highlight on search

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus' --  Remove this option if you want your OS clipboard to remain independent.
opt.breakindent = true -- Enable break indent
opt.undofile = true -- Save undo history

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true -- Don't ignore case with capitals

-- Keep signcolumn on by default
-- vim.wo.signcolumn = 'yes'
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

-- Decrease update time
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.timeout = true
opt.timeoutlen = 300

opt.completeopt = 'menu,menuone,noselect' -- Set completeopt to have a better completion experience
opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
opt.autowrite = true -- Enable auto write
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.scrolloff = 8 -- Number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- Columns of context
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.undolevels = 10000
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.backup = false
opt.swapfile = false

vim.cmd [[set iskeyword+=-]] -- this makes kebab-case one whole word when selecting a word.

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0