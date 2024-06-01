require('nvim-treesitter.configs').setup({
    ensure_installed = {
        -- 'help',
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
    },
    highlight = { enable = true },
    incremental_selection = { enable = true },
})
