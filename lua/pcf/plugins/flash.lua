return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
        char = {
            enabled = false,
        },
        modes = {
            search = { enabled = true },
            char = { jump_labels = true },
        },
    },
  -- stylua: ignore
  keys = {
    { "<leader>if", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash search" },
  },
}
