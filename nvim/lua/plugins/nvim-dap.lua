return {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio', 'leoluz/nvim-dap-go' },
    keys = {
        {
            '<leader>c',
            function()
                local cwd = vim.fn.getcwd()
                local path = cwd .. '/.env'

                local file = io.open(path, 'r')
                if not file then
                    return
                end

                for line in file:lines() do
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

                file:close()

                require('dap').continue()
            end,
        },
        {
            '<leader>n',
            function()
                require('dap').step_over()
            end,
        },
        {
            '<leader>i',
            function()
                require('dap').step_into()
            end,
        },
        {
            '<leader>o',
            function()
                require('dap').step_out()
            end,
        },
        {
            '<leader>b',
            function()
                require('dap').toggle_breakpoint()
            end,
        },
        {
            '<leader>dt',
            function()
                require('dap-go').debug_test()
            end,
        },
        {
            '<leader>ds',
            function()
                require('dap').terminate()
                require('dapui').close()
            end,
        },
        {
            '<leader>dv',
            function()
                require('dapui').eval(nil, { enter = true })
            end,
        },
        {
            '<leader>dl',
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
