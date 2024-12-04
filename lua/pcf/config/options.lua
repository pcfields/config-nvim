-- See `:help vim.o`
-- [[ Setting options ]]
local opt = vim.opt

vim.wo.number = true -- Make line numbers default

vim.g.loaded_netrw = 1 -- Disable native file tree
vim.g.loaded_netrwPlugin = 1
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

opt.autowrite = true -- Enable auto write
opt.backup = false
opt.breakindent = true -- Enable break indent
opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.  Remove this option if you want your OS clipboard to remain independent.
opt.completeopt = 'menu,menuone,noselect' -- Set completeopt to have a better completion experience
opt.conceallevel = 2 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
}
opt.foldcolumn = '1'
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.hlsearch = false -- Set highlight on search
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.iskeyword = opt.iskeyword + '-' -- this makes kebab-case one whole word when selecting a word.
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Number of screen lines to keep above and below the cursor
-- opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.sidescrolloff = 8 -- Columns of context
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartindent = true -- Insert indents automatically
opt.smartcase = true -- Don't ignore case with capitals
opt.smoothscroll = true
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true -- Put new windows right of current
opt.swapfile = false
opt.tabstop = 2 -- Number of spaces tabs count for
opt.showtabline = 0 -- neovim only display tabline when there are at least two tab pages. If you want always display tabline
opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
opt.timeout = true
opt.timeoutlen = 300
opt.undolevels = 10000
opt.undofile = true -- Save undo history
opt.updatetime = 200 -- Decrease update time Save swap file and trigger CursorHold
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
