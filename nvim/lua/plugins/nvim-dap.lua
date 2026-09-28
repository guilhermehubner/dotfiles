return {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio', 'leoluz/nvim-dap-go' },
    keys = {
        {
            '<leader>dc',
            desc = 'DAP: Start/continue debugging (loads .env)',
            function()
                local cwd = vim.fn.getcwd()
                local path = cwd .. '/.env'

                local lines = vim.fn.filereadable(path) == 1 and vim.fn.readfile(path) or {}

                for _, line in ipairs(lines) do
                    -- Trim whitespace
                    line = line:match('^%s*(.-)%s*$')

                    -- Skip empty lines and comments
                    if line ~= '' and not line:match('^#') then
                        -- Remove 'export ' if present
                        line = line:gsub('^export%s+', '')

                        -- Parse KEY=VALUE
                        local key, value = line:match('^([%w_]+)%s*=%s*(.*)$')

                        if key and value then
                            -- Remove surrounding quotes if present
                            value = value:gsub('^[\'"](.*)[\'"]$', '%1')

                            vim.env[key] = value
                        end
                    end
                end

                require('dap').continue()
            end,
        },
        {
            '<leader>dn',
            desc = 'DAP: Step over',
            function()
                require('dap').step_over()
            end,
        },
        {
            '<leader>di',
            desc = 'DAP: Step into',
            function()
                require('dap').step_into()
            end,
        },
        {
            '<leader>do',
            desc = 'DAP: Step out',
            function()
                require('dap').step_out()
            end,
        },
        {
            '<leader>db',
            desc = 'DAP: Toggle breakpoint',
            function()
                require('dap').toggle_breakpoint()
            end,
        },
        {
            '<leader>dt',
            desc = 'DAP: Debug Go test under cursor',
            function()
                require('dap-go').debug_test()
            end,
        },
        {
            '<leader>ds',
            desc = 'DAP: Stop debugging',
            function()
                require('dap').terminate()
                require('dapui').close()
            end,
        },
        {
            '<leader>dv',
            desc = 'DAP: Evaluate expression under cursor',
            function()
                require('dapui').eval(nil, { enter = true })
            end,
        },
        {
            '<leader>dl',
            desc = 'DAP: List breakpoints',
            function()
                require('dap').list_breakpoints()

                require('telescope.builtin').quickfix()
            end,
        },
    },
    config = function()
        require('dap-go').setup()

        local dapui = require('dapui')
        local dap = require('dap')

        dapui.setup()

        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
        end
    end,
}
