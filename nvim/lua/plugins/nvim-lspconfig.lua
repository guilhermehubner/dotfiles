return {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

            -- Mappings.
            local opts = { noremap = true, silent = true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
            buf_set_keymap('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            buf_set_keymap('v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
            buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', '<c-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<leader>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)
            buf_set_keymap('n', '<C-k>', ':lua vim.lsp.buf.hover()<CR>', {})

            if type(client.server_capabilities.codeLensProvider) == 'table' then
                if #client.server_capabilities.codeLensProvider == 0 then
                    return
                end

                buf_set_keymap('n', '<leader>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)

                vim.api.nvim_create_autocmd(
                    'CursorHold,CursorHoldI,InsertLeave',
                    { callback = vim.lsp.codelens.refresh }
                )
            end
        end

        local lsp = require('lspconfig')

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- Set completeopt to have a better completion experience
        vim.o.completeopt = 'menuone,noinsert'

        lsp.gopls.setup({
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

        lsp.lua_ls.setup({
            cmd = { 'lua-language-server' },
            on_attach = function(client, bufnr)
                local supports_method = client.supports_method

                client.supports_method = function(method)
                    if method == 'textDocument/formatting' then
                        return false
                    end

                    return supports_method(method)
                end

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

        local servers = { 'ts_ls', 'pyright', 'phpactor', 'solargraph', 'clangd' }
        for _, l in ipairs(servers) do
            lsp[l].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
            })
        end

        function OrganizeImports()
            local clients = vim.lsp.get_clients()

            for _, client in pairs(clients) do
                local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
                params.context = { only = { 'source.organizeImports' } }

                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 5000)
                for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
                        else
                            vim.lsp.buf.execute_command(r.command)
                        end
                    end
                end
            end
        end

        vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.go', callback = OrganizeImports })
    end,
}
