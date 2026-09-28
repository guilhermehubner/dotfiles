return {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            -- Mappings.
            local function buf_set_keymap(mode, lhs, rhs, desc)
                vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {
                    noremap = true,
                    silent = true,
                    desc = 'LSP: ' .. desc,
                })
            end

            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap(
                'n',
                '<c-]>',
                '<cmd>lua vim.lsp.buf.definition()<CR>',
                'Go to definition'
            )
            buf_set_keymap(
                'n',
                '<leader>gs',
                '<cmd>lua vim.lsp.buf.document_symbol()<CR>',
                'List document symbols'
            )
            buf_set_keymap('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format()<CR>', 'Format file')
            buf_set_keymap(
                'v',
                '<leader>gf',
                '<cmd>lua vim.lsp.buf.format()<CR>',
                'Format selection'
            )
            buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename symbol')
            buf_set_keymap(
                'n',
                '<leader>a',
                '<cmd>lua vim.lsp.buf.code_action()<CR>',
                'Code action'
            )
            buf_set_keymap(
                'n',
                '<c-j>',
                '<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>',
                'Next diagnostic'
            )
            buf_set_keymap(
                'n',
                '<leader>cl',
                '<cmd>lua vim.lsp.codelens.run()<CR>',
                'Run code lens'
            )
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover documentation')

            if client:supports_method('textDocument/codeLens') then
                vim.lsp.codelens.enable(true, { bufnr = bufnr })
            end
        end

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- Set completeopt to have a better completion experience
        vim.o.completeopt = 'menuone,noinsert'

        vim.lsp.config('gopls', {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            settings = {
                gopls = {
                    analyses = { unusedparams = true },
                    staticcheck = true,
                    gofumpt = true,
                    codelenses = { gc_details = true, test = true, generate = true },
                },
            },
        })
		vim.lsp.enable('gopls')

        vim.lsp.config('lua_ls', {
            cmd = { 'lua-language-server' },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                on_attach(client, bufnr)
            end,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                        -- Setup your lua path
                        path = vim.split(package.path, ';'),
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true,
                        },
                    },
                },
            },
        })
		vim.lsp.enable('lua_ls')

        local servers = { 'ts_ls', 'pyright', 'phpactor', 'solargraph', 'clangd' }
        for _, l in ipairs(servers) do
            vim.lsp.config(l, {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
            })
			vim.lsp.enable(l)
        end

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
