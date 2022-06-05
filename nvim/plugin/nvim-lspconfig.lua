-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    buf_set_keymap('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<c-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)

    vim.keymap.set('i', '<C-k>', '<ESC>:lua vim.lsp.buf.signature_help()<CR>a', {})
    vim.keymap.set('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', {})

    if type(client.server_capabilities.codeLensProvider) == 'table' then
        buf_set_keymap('n', '<leader>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)

        vim.api.nvim_create_autocmd('CursorHold,CursorHoldI,InsertLeave',
                                    {callback = vim.lsp.codelens.refresh})
    end
end

local lsp = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'}
}

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert'

lsp.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150},
    init_options = {analyses = {unusedparams = true}, codelenses = {gc_details = true, test = true}}
}

lsp.sumneko_lua.setup {
    cmd = {'lua-language-server'},
    on_attach = function(client, bufnr)
        local supports_method = client.supports_method

        client.supports_method = function(method)
            if method == 'textDocument/formatting' then return false end

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
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

local prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT} ${--config-precedence:configPrecedence}',
    formatStdin = true
}

local yapf = {formatCommand = '/usr/bin/yapf3 --quiet', formatStdin = true}

local autopep8 = {formatCommand = '/usr/bin/autopep8 -', formatStdin = true}

local flake8 = {
    lintCommand = '/usr/bin/flake8 --format \'%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s\' --stdin-display-name ${INPUT} -',
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {'%f:%l:%c: %t%n%n%n %m'},
    lintSource = 'flake8'
}

local mypy = {
    lintCommand = '/usr/bin/mypy --show-column-numbers --ignore-missing-imports',
    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'},
    lintSource = 'mypy'
}

local golangcilint = {lintCommand = 'golangci-lint run', lintSource = 'golanci-lint'}

local lua_format = {
    formatCommand = 'lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=100 --break-after-table-lb --double-quote-to-single-quote',
    formatStdin = true
}

local efm_languages = {
    lua = {lua_format},
    python = {yapf, autopep8, flake8, mypy},
    typescript = {prettier},
    javascript = {prettier},
    typescriptreact = {prettier},
    javascriptreact = {prettier},
    json = {prettier},
    html = {prettier},
    css = {prettier},
    scss = {prettier},
    sass = {prettier},
    markdown = {prettier},
    graphql = {prettier},
    go = {golangcilint}
}

local efm_filetypes = {}
for k, _ in pairs(efm_languages) do table.insert(efm_filetypes, k) end

lsp.efm.setup {
    filetypes = efm_filetypes,
    on_attach = function(client, bufnr)
        local supports_method = client.supports_method

        client.supports_method = function(method)
            local is_go = vim.api.nvim_buf_get_name(bufnr):match('^.+(%..+)$') == '.go'

            if method == 'textDocument/formatting' and is_go then return false end

            return supports_method(method)
        end
    end,
    init_options = {documentFormatting = true},
    root_dir = vim.loop.cwd,
    settings = {rootMarkers = {'.git/'}, languages = efm_languages}
}

local servers = {'tsserver', 'pyright', 'phpactor', 'solargraph', 'clangd'}
for _, l in ipairs(servers) do
    lsp[l].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    }
end

function OrganizeImports()
    local clients = vim.lsp.buf_get_clients()

    for _, client in pairs(clients) do
        local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
        params.context = {only = {'source.organizeImports'}}

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

vim.api.nvim_create_autocmd('BufWritePre', {pattern = '*.go', callback = OrganizeImports})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = {
        '*.py', '*.go', '*.ts', '*.js', '*.lua', '*.json', '*.html', '*.css', '*.scss', '*.sass',
        '*.md', '*.graphql'
    },
    callback = vim.lsp.buf.formatting_sync
})

local fzf_lsp = require 'fzf_lsp'

local function filter(fn)
    return (function(...)
        return (function(err, method, result, client_id, bufnr)
            if vim.tbl_islist(result) then
                result = vim.tbl_filter(function(v)
                    return string.find(v.uri, '_test.go') == nil and string.find(v.uri, 'mock')
                               == nil
                end, result)
            end

            fn(err, method, result, client_id, bufnr)
        end)(...)
    end)
end

vim.lsp.handlers['textDocument/implementation'] = filter(fzf_lsp.implementation_handler)

vim.lsp.handlers['textDocument/references'] = filter(fzf_lsp.references_handler)
