local neotest = require("neotest")

neotest.setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "jest --",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
  },
})

local which_key = require "which-key"

which_key.register {
  ["<leader>tt"] = { "<cmd>lua require'neotest'.run.run()<cr>", "Test Nearest" },
  ["<leader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
  ["<leader>td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Test" },
  ["<leader>ts"] = { "<cmd>lua require('neotest').run.stop()<cr>", "Test Stop" },
  ["<leader>ta"] = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Test" },
}
