local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    -- A list of parser names, or "all"
    ensure_installed = {"typescript", "lua", "rust", "css", "dockerfile", "elm", "haskell", "html", "javascript",
                        "json", "markdown", "scss", "tsx", "vim"},
    highlight = {
        enable = true
    },
    refactor = {
        highlight_current_scope = {
            enable = true
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
