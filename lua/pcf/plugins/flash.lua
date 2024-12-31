return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
        char = {
            enabled = false,
        },
    },
  -- stylua: ignore
  keys = {
    { "<leader>if", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash search" },
  },
}
