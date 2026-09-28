return {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'LSP: ' .. desc })
                end


                map('n', '<c-]>', vim.lsp.buf.definition, 'Go to definition')
                map('n', '<leader>gs', vim.lsp.buf.document_symbol, 'List document symbols')
                map('n', '<leader>gf', vim.lsp.buf.format, 'Format file')
                map('x', '<leader>gf', vim.lsp.buf.format, 'Format selection')
                map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
                map('n', '<leader>a', vim.lsp.buf.code_action, 'Code action')
                map('n', '<c-j>', function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, 'Next diagnostic')
                map('n', '<leader>cl', vim.lsp.codelens.run, 'Run code lens')
                map('n', '<C-k>', vim.lsp.buf.hover, 'Hover documentation')

                if client:supports_method('textDocument/codeLens') then
                    vim.lsp.codelens.enable(true, { bufnr = bufnr })
                end
            end,
        })

        vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

        vim.lsp.config('gopls', {
            settings = {
                gopls = {
                    analyses = { unusedparams = true },
                    staticcheck = true,
                    gofumpt = true,
                    codelenses = { gc_details = true, test = true, generate = true },
                },
            },
        })

        vim.lsp.config('lua_ls', {
            cmd = { 'lua-language-server' },
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })

        vim.lsp.enable({ 'lua_ls', 'gopls', 'ts_ls', 'pyright', 'phpactor', 'solargraph', 'clangd' })

        function OrganizeImports()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/codeAction' })

            for _, client in ipairs(clients) do
                local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
                params.context = { only = { 'source.organizeImports' }, diagnostics = {} }

                local res = client:request_sync('textDocument/codeAction', params, 5000, bufnr)
                for _, r in pairs(res and res.result or {}) do
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
                    end

                    -- r is either a CodeAction (with an optional command table) or a bare Command
                    local cmd = type(r.command) == 'table' and r.command or r
                    if type(cmd.command) == 'string' then
                        client:exec_cmd(cmd, { bufnr = bufnr })
                    end
                end
            end
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('OrganizeImports', { clear = true }),
            pattern = '*.go',
            callback = OrganizeImports,
        })
    end,
}
