return {
    'mfussenegger/nvim-lint',
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = { python = { 'mypy', 'flake8' }, go = { 'golangcilint' } }

        local mypy = lint.linters.mypy

        mypy.args = {
            '--show-column-numbers',
            '--hide-error-codes',
            '--hide-error-context',
            '--no-color-output',
            '--no-error-summary',
            '--no-pretty',
            '--ignore-missing-imports',
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            pattern = { '*.py', '*.go' },
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
