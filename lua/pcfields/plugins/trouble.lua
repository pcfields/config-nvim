-- https://github.com/folke/trouble.nvim

require("trouble").setup {
    icons = true,
    fold_open = "◢", -- icon used for open folds
    fold_closed = "▶", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "E",
        warning = "W",
        hint = "H",
        information = "i"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}