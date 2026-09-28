return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install({
            'go',
            'lua',
            'javascript',
            'tsx',
            'json',
            'yaml',
            'html',
            'css',
            'typescript',
            'python',
            'hcl',
            'graphql',
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
