local cmp = require('cmp')
local types = require('cmp.types')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
        end
    },
    completion = {completeopt = 'menu,menuone,noinsert'},
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item()
    },
    sources = {
        {
            name = 'nvim_lsp',
            entry_filter = function(entry, _)
                local kind = types.lsp.CompletionItemKind[entry:get_kind()]

                if kind == 'Text' then return false end
                return true
            end
        }, {name = 'nvim_lsp_signature_help'}, {name = 'nvim_lua'}, {name = 'path'}
    },
    experimental = {native_menu = false, ghost_text = true}
})

vim.g.completion_sorting = 'none'
