return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "<c-i>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
