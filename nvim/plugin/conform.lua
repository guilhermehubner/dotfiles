local conform = require('conform')
conform.setup({
    formatters_by_ft = {
        lua = { 'lua_format', 'stylua' },
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        sass = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        python = { 'yapf', 'autopep8' },
    },
    format_on_save = { timeout_ms = 2000, lsp_fallback = true, async = false },
    formatters = {
        lua_format = {
            command = 'lua-format',
            args = {
                '-i',
                '--no-keep-simple-function-one-line',
                '--no-break-after-operator',
                '--column-limit=100',
                '--break-after-table-lb',
                '--double-quote-to-single-quote',
            },
        },
    },
})
