-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/jay-babu/mason-nvim-dap.nvim
-- https://github.com/rcarriga/nvim-dap-ui



return {                                -- Debugger
    'mfussenegger/nvim-dap',
    dependencies = {                    -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',         -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim', -- Add your own debuggers here
        'theHamsta/nvim-dap-virtual-text',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'mxsdev/nvim-dap-vscode-js',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require("dapui").setup()
        require("nvim-dap-virtual-text").setup {}

        -- Setup Javascript adapters
        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                -- 💀 Make sure to update this path to point to your installation
                args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
            }
        }

        dap.configurations.javascript = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
        }
        -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = '[Debugger] Toggle last session result' })

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = '[Debugger] Continue' })
        vim.keymap.set('n', '<F1>', dap.step_into, { desc = '[Debugger] Step into' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = '[Debugger] Step over' })
        vim.keymap.set('n', '<F3>', dap.step_out, { desc = '[Debugger] Step out' })

        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[Debugger] Toggle breakpoint' })
        vim.keymap.set('n', '<leader>dB', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = '[Debugger] Set breakpoint condition' })

        -- Setup dap listeners
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
