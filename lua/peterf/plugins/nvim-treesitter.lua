--[[
Description:
  Simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it:  
Link:
    https://github.com/nvim-treesitter/nvim-treesitter
--]] --
local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    autotag = {
        enable = true
    },
    -- A list of parser names, or "all"
    ensure_installed = {"typescript", "lua", "rust", "css", "dockerfile", "elm", "haskell", "html", "javascript",
                        "json", "markdown", "scss", "tsx", "vim"},
    highlight = {
        enable = false
    },
    refactor = {
        highlight_current_scope = {
            enable = false
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "rr"
            }
        },
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true
        }
    }

}
