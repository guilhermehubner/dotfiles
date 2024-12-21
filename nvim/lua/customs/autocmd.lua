-- Syntax for file extensions
vim.api.nvim_create_autocmd(
    { 'BufRead', 'BufNewFile' },
    { pattern = '*.qtpl', command = 'set filetype=html' }
)

-- Remove useless spaces at EOF on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = '%s/\\s\\+$//e' })

-- Mark column limit for languages
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.go',
    command = 'let &colorcolumn=join(range(101,2000),",")',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.py',
    command = 'let &colorcolumn=join(range(81,2000),",")',
})
