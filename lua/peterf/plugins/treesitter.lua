local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    -- A list of parser names, or "all"
    ensure_installed = {"typescript", "lua", "rust", "css", "dockerfile", "elm", "haskell", "html", "javascript",
                        "json", "markdown", "scss", "tsx", "vim"},
    highlight = {
        enable = true
    }
}
