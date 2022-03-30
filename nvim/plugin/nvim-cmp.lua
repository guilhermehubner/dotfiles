local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
        end
    },
    completion = {completeopt = 'menu,menuone,noinsert'},
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = {{name = 'nvim_lsp'}, {name = 'nvim_lsp_signature_help'}},
    experimental = {native_menu = false, ghost_text = true}
})

vim.g.completion_sorting = 'none'
